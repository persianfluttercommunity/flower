import 'package:flower/flower.dart';

import 'package:flutter/material.dart';

/// 0/5 Complete

class TextThemeBuilder extends ThemeBuilderService {
  TextThemeBuilder(List<Style> styles)
      : super(styles
            .where(
                (element) => element.compareTags([StyleTag.all, StyleTag.text]))
            .toList());

  @override
  generate(dynamic theme) {
    if (theme == null) {
      if (style != null) {
        return TextTheme(

            // color: style!.background,
            // opacity: style!.opacity,
            // size: style!.size,
            );
      } else {
        return null;
      }
    } else {
      if (style != null) {
        return (theme as TextTheme).copyWith(
            // color: style!.background ?? theme.color,
            // opacity: style!.opacity ?? theme.opacity,
            // size: style!.size ?? theme.size,
            );
      } else {
        return theme as TextTheme;
      }
    }
  }

  @override
  ThemeData mix(ThemeData data) {
    return data.copyWith(textTheme: generate(data.textTheme));
  }
}
