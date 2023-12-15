import 'dart:async';

import 'package:background_downloader/background_downloader.dart';
import 'package:flutter/material.dart';

enum ButtonState { download, cancel, pause, resume, reset }

class FileDownloaderCustomScreen extends StatefulWidget {
  const FileDownloaderCustomScreen({super.key});

  @override
  State<FileDownloaderCustomScreen> createState() =>
      _FileDownloaderCustomScreenState();
}

class _FileDownloaderCustomScreenState
    extends State<FileDownloaderCustomScreen> {
  final List<DownloadTask> _tasks = [
    DownloadTask(
      url: 'https://www.pexels.com/download/video/3195394/',
      filename: '3195394.mp4',
      allowPause: true,
      displayName: '3195394',
      updates: Updates.statusAndProgress,
    ),
    DownloadTask(
      url: 'https://www.pexels.com/download/video/3209828/-----', //일부러 에러
      filename: '3209828.mp4',
      allowPause: true,
      displayName: '3209828',
      updates: Updates.statusAndProgress,
    ),
    DownloadTask(
      url: 'https://www.pexels.com/download/video/4114797/',
      filename: '4114797.mp4',
      allowPause: true,
      displayName: '4114797',
      updates: Updates.statusAndProgress,
    ),
    DownloadTask(
      url: 'https://www.pexels.com/download/video/5752729/',
      filename: '5752729.mp4',
      allowPause: true,
      displayName: '5752729',
      updates: Updates.statusAndProgress,
    ),
    DownloadTask(
      url: 'https://www.pexels.com/download/video/3756003/',
      filename: '3756003.mp4',
      allowPause: true,
      displayName: '3756003',
      updates: Updates.statusAndProgress,
    ),
  ];

  late StreamController<TaskUpdate> taskUpdateStreamController;

  bool isAllDownloadStart = false;

  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    taskUpdateStreamController = StreamController.broadcast();

    FileDownloader().updates.listen(
      (TaskUpdate update) {
        taskUpdateStreamController.add(update);
        /*
        switch (update) {
          case TaskStatusUpdate _:
            print('task:${update.task.taskId} ${update.status}');
          case TaskProgressUpdate _:
            print('task:${update.task.taskId} $update');
        }
        */
      },
      onDone: () {
        print('onDone');
      },
    );
  }

  @override
  void dispose() {
    taskUpdateStreamController.close();

    FileDownloader().destroy();
    super.dispose();
  }

  Future<void> downloadAllBatch() async {
    await FileDownloader().downloadBatch(
      _tasks,
      batchProgressCallback: (succeeded, failed) => print(
          'Completed ${succeeded + failed} out of ${_tasks.length}, $failed failed'),
      taskStatusCallback: (update) =>
          print('task:${update.task.taskId} status:${update.status}'),
      taskProgressCallback: (update) =>
          print('task:${update.task.taskId} progress:${update.progress}'),
      onElapsedTime: (duration) => print('onElapsedTime:$duration'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('File Downloader Custom')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FractionallySizedBox(
          alignment: Alignment.topCenter,
          widthFactor: 0.7,
          heightFactor: 0.6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Single File Download',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ListItem(
                task: DownloadTask(
                  url: 'https://www.pexels.com/download/video/4214779/',
                  filename: '3195394.mp4',
                  allowPause: true,
                  displayName: '3195394',
                  updates: Updates.statusAndProgress,
                ),
                taskUpdateStreamController: taskUpdateStreamController,
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Multiple Files Download',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _tasks.length,
                  //shrinkWrap: true,
                  itemBuilder: (context, index) => ListItem(
                    task: _tasks[index],
                    taskUpdateStreamController: taskUpdateStreamController,
                    isAllDownloadStart: isAllDownloadStart,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isAllDownloadStart = true;
                  });
                },
                child: const Text('all enqueue download'),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () async {
                    downloadAllBatch();
                  },
                  child: const Text('all downloadBatch download'))
            ],
          ),
        ),
      ),
    );
  }
}

class ListItem extends StatefulWidget {
  const ListItem({
    super.key,
    required this.task,
    required this.taskUpdateStreamController,
    this.isAllDownloadStart = false,
  });

  final DownloadTask task;
  final StreamController<TaskUpdate> taskUpdateStreamController;
  final bool isAllDownloadStart;

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  ButtonState buttonState = ButtonState.download;
  TaskStatus? downloadTaskStatus;
  TaskProgressUpdate? taskProgressUpdate;

  @override
  void didUpdateWidget(covariant ListItem oldWidget) {
    if (widget.isAllDownloadStart) {
      startDownload();
    }
    super.didUpdateWidget(oldWidget);
  }

  Future<void> startDownload() async {
    await FileDownloader().enqueue(widget.task);
  }

  @override
  void initState() {
    widget.taskUpdateStreamController.stream.listen((TaskUpdate update) {
      if (update.task.taskId == widget.task.taskId) {
        switch (update) {
          case TaskStatusUpdate _:
            print('task:${update.task.taskId} ${update.status}');
            buttonState = switch (update.status) {
              TaskStatus.running || TaskStatus.enqueued => ButtonState.pause,
              TaskStatus.paused => ButtonState.resume,
              _ => ButtonState.reset
            };
            setState(() {
              downloadTaskStatus = update.status;
            });
          case TaskProgressUpdate _:
            print('task:${update.task.taskId} $update');
            setState(() {
              taskProgressUpdate = update;
            });
        }
      }
    });

    super.initState();
  }

  Future<void> action() async {
    DownloadTask task = widget.task;

    switch (buttonState) {
      case ButtonState.download:
        await FileDownloader().enqueue(task);
      case ButtonState.cancel:
        await FileDownloader().cancelTaskWithId(task.taskId);
      case ButtonState.reset:
        downloadTaskStatus = null;
        taskProgressUpdate = null;
        buttonState = ButtonState.download;

      case ButtonState.pause:
        await FileDownloader().pause(task);

      case ButtonState.resume:
        await FileDownloader().resume(task);
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    widget.taskUpdateStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.task.url),
              Row(
                children: [
                  Text('${downloadTaskStatus ?? ''}'),
                  const SizedBox(
                    width: 20,
                  ),
                  TextButton(
                    onPressed: () {
                      action();
                    },
                    child: Text(buttonState.name),
                  ),
                ],
              ),
            ],
          ),
          LinearProgressIndicator(
            value: taskProgressUpdate?.progress ?? 0,
            minHeight: 20,
          ),
        ],
      ),
    );
  }
}
