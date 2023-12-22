import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/theme_provider.dart';
import '../models/todo.dart';
import '../providers/todo_list_provider.dart';

class TodoHeader extends ConsumerStatefulWidget {
  const TodoHeader({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TodoHeaderState();
}

class _TodoHeaderState extends ConsumerState<TodoHeader> {
  Widget prevTodoCountWidget = const SizedBox.shrink();

  Widget getActiveTodoCount(List<Todo> todos) {
    final totalCount = todos.length;
    final activeTodoCount =
        todos.where((todo) => !todo.completed).toList().length;

    prevTodoCountWidget = Text(
      '($activeTodoCount/$totalCount item${activeTodoCount != 1 ? "s" : ""} left)',
      style: TextStyle(
        fontSize: 18.0,
        color: Colors.blue[900],
      ),
    );

    return prevTodoCountWidget;
  }

  @override
  Widget build(BuildContext context) {
    final todoListState = ref.watch(todoListProvider);

    todoListState.maybeWhen(
      skipLoadingOnRefresh: false,
      loading: () {},
      orElse: () {},
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Text(
              'TODO',
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 10),
            todoListState.maybeWhen(
              data: (List<Todo> todos) => getActiveTodoCount(todos),
              orElse: () => prevTodoCountWidget,
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                ref.invalidate(todoListProvider);
              },
              icon: const Icon(Icons.refresh),
            ),
            IconButton(
              onPressed: () {
                ref.read(themeProvider.notifier).toggleTheme();
              },
              icon: const Icon(Icons.light_mode),
            ),
            const SizedBox(width: 10),
          ],
        )
      ],
    );
  }
}
