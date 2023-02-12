import 'package:flower/flower.dart';

import 'package:flutter/material.dart';

class UnknownBuilder extends ThemeBuilderService {
  UnknownBuilder(super.styles);

  @override
  generate(dynamic theme) => null;

  @override
  ThemeData mix(ThemeData data) => data;
}
