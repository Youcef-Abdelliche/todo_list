import 'package:flutter/material.dart';

import 'screens/home/components/task_widget.dart';

const Color kPrimaryColor = Color(0xFFF96060);
const Color kSecondryColor = Color(0xFF424360);
const Color kColor = Color(0xFF76DC58);

var months = [
  "JAN",
  "FEB",
  "MAR",
  "APR",
  "MAY",
  "JUN",
  "JUL",
  "AUG",
  "SEP",
  "OCT",
  "NOV",
  "DEC"
];

List<TaskWidget> list=[
TaskWidget(color: Colors.red, name: "Youcef"),
TaskWidget(color: Colors.green, name: "Aymen"),
TaskWidget(color: Colors.blue, name: "Oueis"),
TaskWidget(color: Colors.red, name: "Bacha"),
TaskWidget(color: Colors.red, name: "Brahim"),
];
