import 'package:flower/flower.dart';

import 'package:flutter/material.dart';

/// 0/5 Complete
class ProgressIndicatorThemeBuilder extends ThemeBuilderService {
  ProgressIndicatorThemeBuilder(List<Style> styles)
      : super(styles
            .where((element) =>
                element.compareTags([StyleTag.all, StyleTag.progressIndicator]))
            .toList());

  @override
  generate(dynamic theme) {
    if (theme == null) {
      if (style != null) {
        return ProgressIndicatorThemeData();
      } else {
        return null;
      }
    } else {
      if (style != null) {
        return (theme as ProgressIndicatorThemeData).copyWith();
      } else {
        return theme as ProgressIndicatorThemeData;
      }
    }
  }

  @override
  ThemeData mix(ThemeData data) {
    return data.copyWith(
        progressIndicatorTheme: generate(data.progressIndicatorTheme));
  }
}
