import 'package:flower/flower.dart';
import 'package:flutter/material.dart';

/// 3/5 Complete

class AppbarThemeBuilder extends ThemeBuilderService {
  AppbarThemeBuilder(List<Style> styles)
      : super(styles
            .where((element) =>
                element.compareTags([StyleTag.all, StyleTag.appBar]))
            .toList());

  @override
  generate(dynamic theme) {
    if (theme == null) {
      if (style != null) {
        return AppBarTheme(
          backgroundColor: style!.background,
          shape: style!.shape(),
          elevation: style!.elevation,
          foregroundColor: style!.foreground,
          shadowColor: style!.shadow,
        );
      } else {
        return null;
      }
    } else {
      if (style != null) {
        return (theme as AppBarTheme).copyWith(
          backgroundColor: style!.background ?? theme.backgroundColor,
          shape: style!.shape() ?? theme.shape,
          elevation: style!.elevation ?? theme.elevation,
          foregroundColor: style!.foreground ?? theme.foregroundColor,
          shadowColor: style!.shadow ?? theme.shadowColor,
        );
      } else {
        return theme as AppBarTheme;
      }
    }
  }

  @override
  ThemeData mix(ThemeData data) {
    return data.copyWith(appBarTheme: generate(data.appBarTheme));
  }
}
