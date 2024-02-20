import 'dart:convert';
import 'dart:io';
import 'package:process_run/shell.dart';
import 'package:flutter/material.dart';

class ProcessScreen extends StatefulWidget {
  const ProcessScreen({super.key});

  @override
  State<ProcessScreen> createState() => _ProcessScreenState();
}

class _ProcessScreenState extends State<ProcessScreen> {
  @override
  void initState() {
    process();
    //processRun();
    //processOtherProgram();

    //startOrKillProcess();
    super.initState();
  }

  Future<void> process() async {
    try {
      // 명령 where dart.bat

      final process = await Process.start('dart.bat', ['--version']);

      //final process = await Process.start('notepad.exe', []);
      //final process = await Process.start('notepad', []);

      //final process = await Process.start(
      //    'shutdown', ['/s', '/t', '10']); // /s는 종료, /t는 대기 시간(초) 설정

      // 표준 출력을 읽어오는 방법
      await process.stdout.transform(utf8.decoder).forEach((line) {
        print(line);
      });

      // 표준 에러를 읽어오는 방법
      await process.stderr.transform(utf8.decoder).forEach((line) {
        print(line);
      });

      // 종료 코드를 기다리고 출력
      final exitCode = await process.exitCode;
      print('Exit code: $exitCode');
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> processRun() async {
    var shell = Shell();
    final processResult = await shell.run('''
      dart --version
''');
    print(processResult);
  }

  Future<void> processOtherProgram() async {
    try {
      await processKillOtherProgram();
      final process = await Process.start(
          'D:\\Github\\KEDM\\kedm_player\\PhotoPrintSDKApp\\PhotoPrintSDKApp\\bin\\Debug\\net8.0-windows\\PhotoPrintSDKApp.exe',
          []);
      // 표준 출력을 읽어오는 방법
      await process.stdout.transform(utf8.decoder).forEach((line) {
        print(line);
      });

      // 표준 에러를 읽어오는 방법
      await process.stderr.transform(utf8.decoder).forEach((line) {
        print(line);
      });

      // 종료 코드를 기다리고 출력
      final exitCode = await process.exitCode;
      print('Exit code: $exitCode');
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> processKillOtherProgram() async {
    try {
      final process = await Process.start(
          'taskkill', ['/F', '/IM', 'PhotoPrintSDKApp.exe']);

      // 표준 출력을 읽어오는 방법
      await process.stdout.transform(utf8.decoder).forEach((line) {
        print('stdout: $line');
      });

      // 표준 에러를 읽어오는 방법
      await process.stderr.transform(utf8.decoder).forEach((line) {
        print('stderr: $line');
      });

      // 종료 코드를 기다리고 출력
      final exitCode = await process.exitCode;
      print('Exit code: $exitCode');
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> startOrKillProcess() async {
    const processName = 'PhotoPrintSDKApp.exe';

    // 이미 실행 중인지 확인
    if (await isProcessRunning(processName)) {
      print('$processName is already running. Stopping it...');

      // 이미 실행 중이라면 프로세스 종료
      await killProcess(processName);
    }

    // .exe 프로그램 실행
    await startProcess();
  }

  Future<bool> isProcessRunning(String processName) async {
    try {
      final result =
          await Process.run('tasklist', ['/FI', 'IMAGENAME eq $processName']);

      // tasklist 결과에서 프로세스 이름이 존재하는지 확인
      return result.stdout.toString().contains(processName);
    } catch (e) {
      print('Error checking if $processName is running: $e');
      return false;
    }
  }

  Future<void> killProcess(String processName) async {
    try {
      // 이미 실행 중인 프로세스 종료
      await Process.run('taskkill', ['/F', '/IM', processName]);
    } catch (e) {
      print('Error killing $processName: $e');
    }
  }

  Future<void> startProcess() async {
    try {
      // .exe 프로그램 실행
      final process = await Process.start(
          'D:\\Github\\KEDM\\kedm_player\\PhotoPrintSDKApp\\PhotoPrintSDKApp\\bin\\Debug\\net8.0-windows\\PhotoPrintSDKApp.exe',
          []);

      // 표준 출력을 읽어오는 방법
      await process.stdout.transform(utf8.decoder).forEach((line) {
        print('stdout: $line');
      });

      // 표준 에러를 읽어오는 방법
      await process.stderr.transform(utf8.decoder).forEach((line) {
        print('stderr: $line');
      });

      // 종료 코드를 기다리고 출력
      final exitCode = await process.exitCode;
      print('Exit code: $exitCode');
    } catch (e) {
      print('Error starting PhotoPrintSDKApp.exe: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Process'),
      ),
    );
  }
}
