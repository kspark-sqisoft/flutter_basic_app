import 'dart:async';
import 'dart:io';

import 'package:background_downloader/background_downloader.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

//https://pub.dev/packages/background_downloader

enum ButtonState { download, cancel, pause, resume, reset }

class FileDownloaderScreen extends StatefulWidget {
  const FileDownloaderScreen({super.key});

  @override
  State<FileDownloaderScreen> createState() => _FileDownloaderScreenState();
}

class _FileDownloaderScreenState extends State<FileDownloaderScreen> {
  final List<DownloadTask> _tasks = [
    DownloadTask(
      url: 'https://www.pexels.com/download/video/3195394/',
      filename: '3195394.mp4',
      allowPause: true,
      displayName: '3195394',
      updates: Updates.statusAndProgress,
    ),
    DownloadTask(
      url: 'https://www.pexels.com/download/video/3209828/',
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

  final log = Logger('ExampleApp');
  final buttonTexts = ['Download', 'Cancel', 'Pause', 'Resume', 'Reset'];

  ButtonState buttonState = ButtonState.download;
  bool downloadWithError = false;
  TaskStatus? downloadTaskStatus;
  DownloadTask? backgroundDownloadTask;
  StreamController<TaskProgressUpdate> progressUpdateStream =
      StreamController.broadcast();

  StreamSubscription<TaskProgressUpdate>? progressUpdateStreamSubscription;

  bool loadAndOpenInProgress = false;
  bool loadABunchInProgress = false;

  @override
  void initState() {
    FileDownloader().configure(globalConfig: [
      (Config.requestTimeout, const Duration(seconds: 100)),
    ], androidConfig: [
      (Config.useCacheDir, Config.whenAble),
    ], iOSConfig: [
      (Config.localize, {'Cancel': 'StopIt'}),
    ]).then((result) => debugPrint('Configuration result = $result'));

    // Registering a callback and configure notifications
    FileDownloader()
        .registerCallbacks(
            taskNotificationTapCallback: myNotificationTapCallback)
        .configureNotificationForGroup(FileDownloader.defaultGroup,
            // For the main download button
            // which uses 'enqueue' and a default group
            running: const TaskNotification('Download {filename}',
                'File: {filename} - {progress} - speed {networkSpeed} and {timeRemaining} remaining'),
            complete: const TaskNotification(
                '{displayName} download {filename}', 'Download complete'),
            error: const TaskNotification(
                'Download {filename}', 'Download failed'),
            paused: const TaskNotification(
                'Download {filename}', 'Paused with metadata {metadata}'),
            progressBar: true)
        .configureNotificationForGroup('bunch',
            running: const TaskNotification(
                '{numFinished} out of {numTotal}', 'Progress = {progress}'),
            complete:
                const TaskNotification("Done!", "Loaded {numTotal} files"),
            error: const TaskNotification(
                'Error', '{numFailed}/{numTotal} failed'),
            progressBar: false,
            groupNotificationId: 'notGroup')
        .configureNotification(
            // for the 'Download & Open' dog picture
            // which uses 'download' which is not the .defaultGroup
            // but the .await group so won't use the above config
            complete: const TaskNotification(
                'Download {filename}', 'Download complete'),
            tapOpensFile: true); // dog can also open directly from tap

    // Listen to updates and process
    FileDownloader().updates.listen((update) {
      switch (update) {
        case TaskStatusUpdate _:
          if (update.task == backgroundDownloadTask) {
            buttonState = switch (update.status) {
              TaskStatus.running || TaskStatus.enqueued => ButtonState.pause,
              TaskStatus.paused => ButtonState.resume,
              _ => ButtonState.reset
            };
            setState(() {
              downloadTaskStatus = update.status;
            });
          }

        case TaskProgressUpdate _:
          progressUpdateStream.add(update); // pass on to widget for indicator
      }
    });

    progressUpdateStreamSubscription = progressUpdateStream.stream
        .listen((TaskProgressUpdate taskProgressUpdate) {
      print('taskProgressUpdate:$taskProgressUpdate');
    });

    super.initState();
  }

  void myNotificationTapCallback(Task task, NotificationType notificationType) {
    debugPrint(
        'Tapped notification $notificationType for taskId ${task.taskId}');
  }

  @override
  void dispose() {
    progressUpdateStreamSubscription?.cancel();
    FileDownloader().destroy();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File Downloader'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                        child: Text('Force error',
                            style: Theme.of(context).textTheme.titleLarge)),
                    Switch(
                        value: downloadWithError,
                        onChanged: (value) {
                          setState(() {
                            downloadWithError = value;
                          });
                        })
                  ],
                ),
              ),
              Center(
                  child: ElevatedButton(
                onPressed: processButtonPress,
                child: Text(
                  buttonTexts[buttonState.index],
                ),
              )),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Expanded(child: Text('File download status:')),
                    Text('${downloadTaskStatus ?? "undefined"}')
                  ],
                ),
              ),
              const Divider(
                height: 30,
                thickness: 5,
                color: Colors.blueGrey,
              ),
              Center(
                  child: ElevatedButton(
                      onPressed:
                          loadAndOpenInProgress ? null : processLoadAndOpen,
                      child: Text(
                        Platform.isIOS ? 'Load, open and add' : 'Load & Open',
                      ))),
              Center(
                  child: Text(
                loadAndOpenInProgress ? 'Busy' : '',
              )),
              const Divider(
                height: 30,
                thickness: 5,
                color: Colors.blueGrey,
              ),
              Center(
                  child: ElevatedButton(
                      onPressed:
                          loadABunchInProgress ? null : processLoadABunch,
                      child: const Text('Load a bunch'))),
              Center(child: Text(loadABunchInProgress ? 'Enqueueing' : '')),
              const Divider(
                height: 30,
                thickness: 5,
                color: Colors.blueGrey,
              ),
              DownloadProgressIndicator(
                progressUpdateStream.stream,
                showPauseButton: true,
                showCancelButton: true,
                backgroundColor: Colors.grey,
                maxExpandable: 1,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> processButtonPress() async {
    switch (buttonState) {
      case ButtonState.download:
        // start download
        await getPermission(PermissionType.notifications);
        backgroundDownloadTask = _tasks[0];
        await FileDownloader().enqueue(backgroundDownloadTask!);
        break;
      case ButtonState.cancel:
        // cancel download
        if (backgroundDownloadTask != null) {
          await FileDownloader()
              .cancelTasksWithIds([backgroundDownloadTask!.taskId]);
        }
        break;
      case ButtonState.reset:
        downloadTaskStatus = null;
        buttonState = ButtonState.download;
        break;
      case ButtonState.pause:
        if (backgroundDownloadTask != null) {
          await FileDownloader().pause(backgroundDownloadTask!);
        }
        break;
      case ButtonState.resume:
        if (backgroundDownloadTask != null) {
          await FileDownloader().resume(backgroundDownloadTask!);
        }
        break;
    }
    if (mounted) {
      setState(() {});
    }
  }

  /// Process 'Load & Open' button
  ///
  /// Loads a JPG of a dog and launches viewer using [openFile]
  Future<void> processLoadAndOpen() async {
    if (!loadAndOpenInProgress) {
      await getPermission(PermissionType.notifications);
      var task = _tasks[0];
      setState(() {
        loadAndOpenInProgress = true;
      });
      await FileDownloader().download(task);
      await FileDownloader().openFile(task: task);
      if (Platform.isIOS) {
        // add to photos library and print path
        // If you need the path, ask full permissions beforehand by calling
        var auth = await FileDownloader()
            .permissions
            .status(PermissionType.iosChangePhotoLibrary);
        if (auth != PermissionStatus.granted) {
          auth = await FileDownloader()
              .permissions
              .request(PermissionType.iosChangePhotoLibrary);
        }
        if (auth == PermissionStatus.granted) {
          final identifier = await FileDownloader()
              .moveToSharedStorage(task, SharedStorage.images);
          if (identifier != null) {
            final path = await FileDownloader()
                .pathInSharedStorage(identifier, SharedStorage.images);
            debugPrint(
                'iOS path to dog picture in Photos Library = ${path ?? "permission denied"}');
          } else {
            debugPrint(
                'Could not add file to Photos Library, likely because permission denied');
          }
        } else {
          debugPrint('iOS Photo Library permission not granted');
        }
      }
      setState(() {
        loadAndOpenInProgress = false;
      });
    }
  }

  Future<void> processLoadABunch() async {
    if (!loadABunchInProgress) {
      setState(() {
        loadABunchInProgress = true;
      });
      await getPermission(PermissionType.notifications);
      for (var i = 0; i < _tasks.length; i++) {
        await FileDownloader()
            .enqueue(_tasks[i]); // must provide progress updates!
        await Future.delayed(const Duration(milliseconds: 500));
      }
      setState(() {
        loadABunchInProgress = false;
      });
    }
  }

  /// Attempt to get permissions if not already granted
  Future<void> getPermission(PermissionType permissionType) async {
    var status = await FileDownloader().permissions.status(permissionType);
    if (status != PermissionStatus.granted) {
      if (await FileDownloader()
          .permissions
          .shouldShowRationale(permissionType)) {
        debugPrint('Showing some rationale');
      }
      status = await FileDownloader().permissions.request(permissionType);
      debugPrint('Permission for $permissionType was $status');
    }
  }
}
