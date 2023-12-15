import 'package:background_downloader/background_downloader.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class FileDownloaderBatchScreen extends StatefulWidget {
  const FileDownloaderBatchScreen({super.key});

  @override
  State<FileDownloaderBatchScreen> createState() =>
      _FileDownloaderBatchScreenState();
}

class _FileDownloaderBatchScreenState extends State<FileDownloaderBatchScreen> {
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

  int totalCount = 0;
  int currentCount = 0;

  @override
  void initState() {
    super.initState();
  }

  Future<void> downloadAllBatch() async {
    setState(() {
      totalCount = _tasks.length;
      currentCount = 0;
    });
    await FileDownloader().downloadBatch(
      _tasks,
      batchProgressCallback: (succeeded, failed) {
        print(
            'Completed ${succeeded + failed} out of ${_tasks.length}, $failed failed');
        setState(() {
          totalCount = _tasks.length;
          currentCount = succeeded + failed;
        });
      },
      taskStatusCallback: (update) {
        print('task:${update.task.filename} status:${update.status}');
      },
      taskProgressCallback: (update) {
        print(
            'task:${update.task.filename} progress:${update.progress} expectedFileSize:${update.expectedFileSize} expectedFileSizeString: ${formatBytes(update.expectedFileSize, 1)}  networkSpeedAsString:${update.networkSpeedAsString}');
      },
      onElapsedTime: (duration) {
        print('onElapsedTime:$duration');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File Downloader Batch'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              LinearProgressIndicator(
                value: totalCount == 0 ? 0 : currentCount / totalCount,
                minHeight: 50,
              ),
              const SizedBox(
                height: 10,
              ),
              Text('$currentCount/$totalCount'),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  downloadAllBatch();
                },
                child: const Text('all files download'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

String formatBytes(int bytes, int decimals) {
  if (bytes <= 0) return "0 B";
  const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
  var i = (log(bytes) / log(1024)).floor();
  return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)}${suffixes[i]}';
}
