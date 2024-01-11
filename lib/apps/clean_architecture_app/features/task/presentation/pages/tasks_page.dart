import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../di/injection.dart' as di;

import 'package:uuid/uuid.dart';

import '../../domain/entities/task.dart';
import '../../domain/usecases/add_task.dart';
import '../../domain/usecases/delete_task.dart';
import '../../domain/usecases/delete_tasks.dart';
import '../../domain/usecases/get_tasks.dart';
import '../bloc/tasks_bloc.dart';
import '../bloc/tasks_event.dart';
import '../bloc/tasks_state.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('tasks')),
      body: BlocProvider(
        create: (context) => TasksBloc(
          getTasks: di.locator<GetTasks>(),
          addTask: di.locator<AddTask>(),
          deleteTask: di.locator<DeleteTask>(),
          deleteTasks: di.locator<DeleteTasks>(),
        )..add(TasksFetched()),
        child: const TasksList(),
      ),
    );
  }
}

class TasksList extends StatelessWidget {
  const TasksList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<TasksBloc, TasksState>(
            builder: (context, state) {
              print(state);
              switch (state.status) {
                case TasksStatus.initial:
                  return const SizedBox.shrink();
                case TasksStatus.loading:
                  return const Center(child: CircularProgressIndicator());
                case TasksStatus.loaded:
                  final tasks = state.tasks;
                  return ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];
                        return SizedBox(
                          child: ListTile(
                            leading: Text(task.title),
                            title: Text(task.description),
                            trailing: IconButton(
                              icon: const Icon(Icons.remove_circle),
                              onPressed: () {
                                context
                                    .read<TasksBloc>()
                                    .add(TasksDeleted(task: task));
                              },
                            ),
                          ),
                        );
                      });
                case TasksStatus.failure:
                  return const Center(
                    child: Text('error'),
                  );
              }
            },
          ),
        ),
        const AddTaskForm(),
      ],
    );
  }
}

class AddTaskForm extends StatefulWidget {
  const AddTaskForm({super.key});

  @override
  State<AddTaskForm> createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksBloc, TasksState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    maxLength: 60,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),
                    controller: _nameController,
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter task name' : null,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      labelText: 'New Task',
                      counterText: '',
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.withOpacity(0.7),
                          width: 0,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      fillColor: Colors.grey.withOpacity(0.1),
                      prefixIcon: Icon(
                        Icons.info_outline_rounded,
                        color: Colors.blue.withOpacity(.8),
                      ),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        maxLength: 60,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                        controller: _detailsController,
                        validator: (val) =>
                            val!.isEmpty ? 'Please enter task details' : null,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          labelText: 'Details',
                          counterText: '',
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.withOpacity(0.7),
                              width: 0,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          fillColor: Colors.grey.withOpacity(0.1),
                          prefixIcon: Icon(
                            Icons.info_outline_rounded,
                            color: Colors.blue.withOpacity(.8),
                          ),
                        ),
                      )),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    height: 50.0,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(5),
                        textStyle: const TextStyle(
                          color: Color.fromRGBO(0, 160, 227, 1),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: const BorderSide(
                              color: Color.fromRGBO(0, 160, 227, 1)),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<TasksBloc>().add(TasksAdded(
                              task: Task(
                                  id: const Uuid().v4(),
                                  title: _nameController.text,
                                  description: _detailsController.text)));
                          _formKey.currentState!.reset();
                        }
                      },
                      child: const Text("Add Task",
                          style: TextStyle(fontSize: 15)),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    height: 50.0,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(5),
                        textStyle: const TextStyle(
                          color: Color.fromRGBO(0, 160, 227, 1),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: const BorderSide(
                              color: Color.fromRGBO(0, 160, 227, 1)),
                        ),
                      ),
                      onPressed: () {
                        context.read<TasksBloc>().add(TasksAllDeleted());
                        _formKey.currentState!.reset();
                      },
                      child: const Text("Delete All Task",
                          style: TextStyle(fontSize: 15)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
