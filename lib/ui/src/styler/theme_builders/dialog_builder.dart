import 'package:flower/flower.dart';

import 'package:flutter/material.dart';

/// 3/5 Complete

class DialogThemeBuilder extends ThemeBuilderService {
  DialogThemeBuilder(List<Style> styles)
      : super(styles
            .where(
                (element) => element.compareTags([StyleTag.all, StyleTag.text]))
            .toList());

  @override
  generate(dynamic theme) {
    if (theme == null) {
      if (style != null) {
        return DialogTheme(
          alignment: style!.alignment,
          backgroundColor: style!.background,
          iconColor: style!.foreground,
          shape: style!.shape(),
          elevation: style!.elevation,

          // actionsPadding: ???
          // titleTextStyle:
        );
      } else {
        return null;
      }
    } else {
      if (style != null) {
        return (theme as DialogTheme).copyWith(
          alignment: style!.alignment ?? theme.alignment,
          backgroundColor: style!.background ?? theme.backgroundColor,
          iconColor: style!.foreground ?? theme.iconColor,
          shape: style!.shape() ?? theme.shape,
          elevation: style!.elevation ?? theme.elevation,
        );
      } else {
        return theme as DialogTheme;
      }
    }
  }

  @override
  ThemeData mix(ThemeData data) {
    return data.copyWith(dialogTheme: generate(data.dialogTheme));
  }
}
