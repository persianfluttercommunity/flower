import 'package:flower/flower.dart';
import 'package:flutter/material.dart';

// import 'index.dart';

class ThemeBuilder<T extends Widget> {
  late ThemeBuilderService _service;

  ThemeBuilder({required List<Style> styles}) {
    _service = _identify(styles);
  }

  dynamic generate() {
    return _service.generate(null);
  }

  ThemeData mix(ThemeData themeData) {
    return _service.mix(themeData);
  }

  ThemeBuilderService _identify(List<Style> styles) {
    switch (T) {
      case AppBar:
        return AppbarThemeBuilder(styles);
      case Card:
        return CardThemeBuilder(styles);
      case Icon:
        return IconThemeBuilder(styles);
      case Text:
        return TextThemeBuilder(styles);
      case Radio:
        return RadioThemeBuilder(styles);
      case Dialog:
        return DialogThemeBuilder(styles);
      case Drawer:
        return DrawerThemeBuilder(styles);
      case Slider:
        return SliderThemeBuilder(styles);
      case Switch:
        return SwitchThemeBuilder(styles);
      case TabBar:
        return TabBarThemeBuilder(styles);
      case ListTile:
        return ListTileThemeBuilder(styles);
      case CheckboxListTile:
        return CheckBoxThemeBuilder(styles);
      case SnackBar:
        return SnackBarThemeBuilder(styles);
      case BottomSheet:
        return BottomSheetThemeBuilder(styles);
      case ExpansionTile:
        return ExpansionTileThemeBuilder(styles);
      case ToggleButtons:
        return ToggleButtonsThemeBuilder(styles);
      case ProgressIndicator:
      case LinearProgressIndicator:
      case CircularProgressIndicator:
        return ProgressIndicatorThemeBuilder(styles);
      case FloatingActionButton:
        return FloatingActionButtonThemeBuilder(styles);
      default:
        return UnknownBuilder(styles);
    }
  }
}
