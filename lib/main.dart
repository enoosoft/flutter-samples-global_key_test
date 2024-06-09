import 'package:flutter/material.dart';
import 'package:global_key_test/widgets/parent.dart';

void main() {
  runApp(const Parent());
}

class SnackbarGlobal {
  static GlobalKey<ScaffoldMessengerState> key =
      GlobalKey<ScaffoldMessengerState>();

  static void show(String message) {
    key.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
          content: Text(message), duration: const Duration(seconds: 5)));
  }
}
