import 'package:flower/flower.dart';

import 'package:flutter/material.dart';

/// 0/5 Complete
class SnackBarThemeBuilder extends ThemeBuilderService {
  SnackBarThemeBuilder(List<Style> styles)
      : super(styles
            .where((element) =>
                element.compareTags([StyleTag.all, StyleTag.snackBar]))
            .toList());

  @override
  generate(dynamic theme) {
    if (theme == null) {
      if (style != null) {
        return SnackBarThemeData();
      } else {
        return null;
      }
    } else {
      if (style != null) {
        return (theme as SnackBarThemeData).copyWith();
      } else {
        return theme as SnackBarThemeData;
      }
    }
  }

  @override
  ThemeData mix(ThemeData data) {
    return data.copyWith(snackBarTheme: generate(data.snackBarTheme));
  }
}
