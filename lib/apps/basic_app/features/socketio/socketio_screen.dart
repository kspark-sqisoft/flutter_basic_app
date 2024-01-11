import 'dart:io';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketIOScreen extends StatefulWidget {
  const SocketIOScreen({super.key});

  @override
  State<SocketIOScreen> createState() => _SocketIOScreenState();
}

class _SocketIOScreenState extends State<SocketIOScreen> {
  Socket? socket;
  void connect() {
    socket = io('http://localhost:8080/io/history',
        OptionBuilder().setTransports(['websocket']).build());

    socket?.onConnect((_) {
      print('connected');
    });

    socket?.onDisconnect((_) {
      print('disconnected');
    });

    socket?.on('message', (data) {
      print(data);
    });

    socket?.connect();
  }

  void disconnect() {
    socket?.disconnect();
    socket?.dispose();
  }

  @override
  void dispose() {
    disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Socket IO')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              connect();
            },
            child: const Text('connect'),
          ),
          ElevatedButton(
            onPressed: () {
              socket?.emit('message', '{"name": "keesoon"}');
            },
            child: const Text('send msg'),
          ),
          ElevatedButton(
            onPressed: () {
              disconnect();
            },
            child: const Text('disconnect'),
          ),
        ],
      ),
    );
  }
}
