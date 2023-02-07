import 'package:flutter/material.dart';

class LogProfile {
  LogProfile({
    required this.tag,
    required this.visible,
    this.color = Colors.white,
  });
  String tag;
  Color color;
  bool visible;
}
