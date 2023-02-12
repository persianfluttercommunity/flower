import 'package:flower/flower.dart';

import 'package:flutter/material.dart';

/// 0/5 Complete
class ToggleButtonsThemeBuilder extends ThemeBuilderService {
  ToggleButtonsThemeBuilder(List<Style> styles)
      : super(styles
            .where((element) =>
                element.compareTags([StyleTag.all, StyleTag.toggleButton]))
            .toList());

  @override
  generate(dynamic theme) {
    if (theme == null) {
      if (style != null) {
        return ToggleButtonsThemeData();
      } else {
        return null;
      }
    } else {
      if (style != null) {
        return (theme as ToggleButtonsThemeData).copyWith();
      } else {
        return theme as ToggleButtonsThemeData;
      }
    }
  }

  @override
  ThemeData mix(ThemeData data) {
    return data.copyWith(toggleButtonsTheme: generate(data.toggleButtonsTheme));
  }
}
