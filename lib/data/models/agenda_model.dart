import 'package:flutter/material.dart';

class AgendaEvent {
  final String title;
  final String description;
  final bool isMultiDay;
  final DateTime startTime; // Digunakan untuk Single & Start Date
  final DateTime endTime;   // Digunakan untuk End Date
  final TimeOfDay timeStart;
  final TimeOfDay timeEnd;
  final Color color;

  AgendaEvent({
    required this.title,
    required this.description,
    required this.isMultiDay,
    required this.startTime,
    required this.endTime,
    required this.timeStart,
    required this.timeEnd,
    required this.color,
  });
}