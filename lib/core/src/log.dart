import 'dart:developer' as developer;

import 'package:flower/core/src/log_profile.dart';
import 'package:flower/flower.dart';

///VoidCallback from logs
typedef Logger = void Function(String message, {String? tag});

/// default logger from Flower
void defaultLogger(String message, {String? tag}) {
  /// Search in LogProfiles for its profile

  if (Flower.isLogEnable) {
    developer.log(message, name: tag ?? 'Flower :');
  }
}
