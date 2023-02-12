import 'package:flower/flower.dart';

import 'package:flutter/material.dart';

/// 0/5 Complete
class CheckBoxThemeBuilder extends ThemeBuilderService {
  CheckBoxThemeBuilder(List<Style> styles)
      : super(styles
            .where((element) =>
                element.compareTags([StyleTag.all, StyleTag.checkBox]))
            .toList());

  @override
  generate(dynamic theme) {
    if (theme == null) {
      if (style != null) {
        return CheckboxThemeData();
      } else {
        return null;
      }
    } else {
      if (style != null) {
        return (theme as CheckboxThemeData).copyWith();
      } else {
        return theme as CheckboxThemeData;
      }
    }
  }

  @override
  ThemeData mix(ThemeData data) {
    return data.copyWith(checkboxTheme: generate(data.checkboxTheme));
  }
}
