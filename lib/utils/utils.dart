import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void showSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}

String formatToLocalDate(DateTime dateTime) {
  final format = "MMM/dd/yyyy hh:mm:ss a";
  return formatDateTime(format, dateTime);
}

String formatDateTime(String format, DateTime dateTime) {
  final formatter = DateFormat(format);
  return formatter.format(dateTime);
}
