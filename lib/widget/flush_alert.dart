import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

Widget flushAlert(context, String messages) {
  return Flushbar(
    flushbarPosition: FlushbarPosition.TOP,
    message: messages,
    icon: const Icon(
      Icons.info_outline,
      size: 25.0,
      color: Colors.white,
    ),
    backgroundColor: Colors.red,
    duration: const Duration(seconds: 3),
    margin: const EdgeInsets.all(15),
    borderRadius: BorderRadius.circular(15),
  )..show(context);
}
