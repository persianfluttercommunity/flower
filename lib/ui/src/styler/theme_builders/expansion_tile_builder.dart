import 'package:flower/flower.dart';

import 'package:flutter/material.dart';

/// 0/5 Complete
class ExpansionTileThemeBuilder extends ThemeBuilderService {
  ExpansionTileThemeBuilder(List<Style> styles)
      : super(styles
            .where((element) =>
                element.compareTags([StyleTag.all, StyleTag.expansionTile]))
            .toList());

  @override
  generate(dynamic theme) {
    if (theme == null) {
      if (style != null) {
        return ExpansionTileThemeData();
      } else {
        return null;
      }
    } else {
      if (style != null) {
        return (theme as ExpansionTileThemeData).copyWith();
      } else {
        return theme as ExpansionTileThemeData;
      }
    }
  }

  @override
  ThemeData mix(ThemeData data) {
    return data.copyWith(expansionTileTheme: generate(data.expansionTileTheme));
  }
}
