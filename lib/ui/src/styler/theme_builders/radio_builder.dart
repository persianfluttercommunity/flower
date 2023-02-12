import 'package:flower/flower.dart';

import 'package:flutter/material.dart';

/// 1/5 Complete

class RadioThemeBuilder extends ThemeBuilderService {
  RadioThemeBuilder(List<Style> styles)
      : super(styles
            .where((element) =>
                element.compareTags([StyleTag.all, StyleTag.radio]))
            .toList());

  @override
  generate(dynamic theme) {
    if (theme == null) {
      if (style != null) {
        return RadioThemeData(
          fillColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return style!.primary!;
            }
            return style!.foreground!;
          }),
        );
      } else {
        return null;
      }
    } else {
      if (style != null) {
        return (theme as RadioThemeData).copyWith(
            // color: style!.background ?? theme.color,
            );
      } else {
        return theme as RadioThemeData;
      }
    }
  }

  @override
  ThemeData mix(ThemeData data) {
    return data.copyWith(radioTheme: generate(data.radioTheme));
  }
}
