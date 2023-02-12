import 'package:flower/flower.dart';

import 'package:flutter/material.dart';

/// 0/5 Complete

class SliderThemeBuilder extends ThemeBuilderService {
  SliderThemeBuilder(List<Style> styles)
      : super(styles
            .where((element) =>
                element.compareTags([StyleTag.all, StyleTag.slider]))
            .toList());

  @override
  generate(dynamic theme) {
    if (theme == null) {
      if (style != null) {
        return SliderThemeData();
      } else {
        return null;
      }
    } else {
      if (style != null) {
        return (theme as SliderThemeData).copyWith();
      } else {
        return theme as SliderThemeData;
      }
    }
  }

  @override
  ThemeData mix(ThemeData data) {
    return data.copyWith(sliderTheme: generate(data.sliderTheme));
  }
}
