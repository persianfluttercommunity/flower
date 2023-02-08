import 'package:flutter/widgets.dart';

import 'default_route.dart';

enum Transition {
  fade,
  fadeIn,
  rightToLeft,
  leftToRight,
  upToDown,
  downToUp,
  rightToLeftWithFade,
  leftToRightWithFade,
  zoom,
  topLevel,
  noTransition,
  cupertino,
  cupertinoDialog,
  size,
  circularReveal,
  native,
}

typedef FatimaPageBuilder = Widget Function();
typedef FatimaRouteAwarePageBuilder<T> = Widget Function(
    [FlowerPageRoute<T>? route]);
