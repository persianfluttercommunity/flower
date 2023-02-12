import 'package:flower/flower.dart';

import 'package:flutter/material.dart';

/// 0/5 Complete
class ListTileThemeBuilder extends ThemeBuilderService {
  ListTileThemeBuilder(List<Style> styles)
      : super(styles
            .where((element) =>
                element.compareTags([StyleTag.all, StyleTag.tabBar]))
            .toList());

  @override
  generate(dynamic theme) {
    if (theme == null) {
      if (style != null) {
        return ListTileThemeData();
      } else {
        return null;
      }
    } else {
      if (style != null) {
        return (theme as ListTileThemeData).copyWith();
      } else {
        return theme as ListTileThemeData;
      }
    }
  }

  @override
  ThemeData mix(ThemeData data) {
    return data.copyWith(listTileTheme: generate(data.listTileTheme));
  }
}
