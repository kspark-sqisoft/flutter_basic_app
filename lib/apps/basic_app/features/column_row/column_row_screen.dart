import 'package:flutter/material.dart';

class ColumnRowScreen extends StatelessWidget {
  const ColumnRowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Column Row')),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 400,
            height: 400,
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          //width: 100,
                          //height: 100,
                          color: Colors.red,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          //width: 100,
                          //height: 100,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          //width: 100,
                          //height: 100,
                          color: Colors.lightBlue,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          //width: 100,
                          //height: 100,
                          color: Colors.lightGreen,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          //ListView가 Column, Row 안에 있으면 SizedBox나 Expanded 로 묵어 준다. shrinkWrap을 true로 해도 된다(성능 하락)
          SizedBox(
            width: 600,
            height: 500,
            child: ListView.builder(
              itemCount: 24,
              itemBuilder: (context, index) => const ListViewItem(),
            ),
          )
        ],
      ),
    );
  }
}

class ListViewItem extends StatelessWidget {
  const ListViewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 100, maxHeight: 100),
        color: Colors.amber,
        child: Container(width: 300, height: 300, color: Colors.red),
      ),
    );
  }
}
