import 'package:flower/core/flower_core.dart';
import 'package:flutter/foundation.dart';

import 'flower.dart';

abstract class FlowerInterface {
  // SmartManagement smartManagement = SmartManagement.full;
  bool isLogEnable = kDebugMode;
  Logger log = defaultLogger;

  String version = "1.0.0";
}
