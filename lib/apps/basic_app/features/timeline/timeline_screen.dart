import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({super.key});

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  DateTime? _focusDate;
  final EasyInfiniteDateTimelineController _controller =
      EasyInfiniteDateTimelineController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timeline'),
      ),
      body: EasyInfiniteDateTimeLine(
        controller: _controller,
        firstDate: DateTime(2023),
        focusDate: _focusDate,
        lastDate: DateTime(2023, 12, 31),
        onDateChange: (selectedDate) {
          setState(() {
            _focusDate = selectedDate;
          });
        },
      ),
    );
  }
}
