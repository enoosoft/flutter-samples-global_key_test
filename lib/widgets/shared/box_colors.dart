import 'package:flutter/material.dart';

enum EnmBoxColor {
  parent,
  son,
  grandSon,
  ;

  Color get color {
    MaterialColor color = Colors.blue;
    int factor = index; //3 - index;
    return color[(factor + 1) * 100] ?? Colors.transparent;
  }
}
