import 'package:flutter/material.dart';

void sayName(BuildContext context, String name) {
  //for 2 seconds
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('$name 입니다'),
      duration: const Duration(seconds: 1),
    ),
  );
}
