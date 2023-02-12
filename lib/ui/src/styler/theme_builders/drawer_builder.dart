import 'package:flower/flower.dart';

import 'package:flutter/material.dart';

/// 4/5 Complete
class DrawerThemeBuilder extends ThemeBuilderService {
  DrawerThemeBuilder(List<Style> styles)
      : super(styles
            .where((element) =>
                element.compareTags([StyleTag.all, StyleTag.drawer]))
            .toList());

  @override
  generate(dynamic theme) {
    if (theme == null) {
      if (style != null) {
        return DrawerThemeData(
          backgroundColor: style!.background,
          shape: style!.shape(),
          elevation: style!.elevation,
          width: style!.width,
        );
      } else {
        return null;
      }
    } else {
      if (style != null) {
        return (theme as DrawerThemeData).copyWith(
          backgroundColor: style!.background ?? theme.backgroundColor,
          shape: style!.shape() ?? theme.shape,
          elevation: style!.elevation ?? theme.elevation,
          width: style!.width ?? theme.width,
        );
      } else {
        return theme as DrawerThemeData;
      }
    }
  }

  @override
  ThemeData mix(ThemeData data) {
    return data.copyWith(drawerTheme: generate(data.drawerTheme));
  }
}
