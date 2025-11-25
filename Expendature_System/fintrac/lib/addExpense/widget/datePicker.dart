import 'package:flutter/material.dart';

Future<DateTime?> pickDate(BuildContext context, DateTime initialDate) async {
  final DateTime? newDate = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );
  return newDate;
}
