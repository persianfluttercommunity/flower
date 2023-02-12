import 'package:flower/flower.dart';

import 'package:flutter/material.dart';

/// 0/5 Complete
class TabBarThemeBuilder extends ThemeBuilderService {
  TabBarThemeBuilder(List<Style> styles)
      : super(styles
            .where((element) =>
                element.compareTags([StyleTag.all, StyleTag.tabBar]))
            .toList());

  @override
  generate(dynamic theme) {
    if (theme == null) {
      if (style != null) {
        return TabBarTheme();
      } else {
        return null;
      }
    } else {
      if (style != null) {
        return (theme as TabBarTheme).copyWith();
      } else {
        return theme as TabBarTheme;
      }
    }
  }

  @override
  ThemeData mix(ThemeData data) {
    return data.copyWith(tabBarTheme: generate(data.tabBarTheme));
  }
}
