import 'package:flower/flower.dart';
import 'package:flutter/material.dart';

class UIConfig {
  // final _box = Storage();
  bool storable = false;
  late ThemeData lightTheme;
  late ThemeData darkTheme;
  ThemeMode? themeMode = ThemeMode.system;
  List<Style> defaultStyles = [];

  UIConfig({
    ThemeData? light,
    ThemeData? dark,
    List<Style>? styles,
    // Style? appbar,
  }) {
    defaultStyles = styles ?? [];
    _initializeThemes(light, dark);
  }

  void _initializeThemes(ThemeData? light, ThemeData? dark) {
    lightTheme = light ??
        _generateThemeData(
            ThemeMode.light,
            defaultStyles
                .where((element) => element.mode == ThemeMode.light)
                .toList());
    darkTheme = dark ??
        _generateThemeData(
            ThemeMode.dark,
            defaultStyles
                .where((element) => element.mode == ThemeMode.dark)
                .toList());
  }

  ThemeData _generateThemeData(ThemeMode mode, List<Style> styles) {
    Style? mainStyle = styles.firstOrNull;
    for (var element in styles.where(
        (element) => element.compareTags([StyleTag.all, StyleTag.main]))) {
      mainStyle!.merge(element);
    }

    mainStyle ??=
        mode == ThemeMode.light ? defaultLightStyle() : defaultDarkStyle();

    return ThemeData(
      fontFamily: mainStyle.fontFamily ?? 'Vazir',
      backgroundColor: mainStyle.background,
      primaryColor: mainStyle.primary,
      appBarTheme: ThemeBuilder<AppBar>(styles: styles).generate(),
      cardTheme: ThemeBuilder<Card>(styles: styles).generate(),
      iconTheme: ThemeBuilder<Icon>(styles: styles).generate(),
      textTheme: ThemeBuilder<Text>(styles: styles).generate(), // Complicated
      radioTheme: ThemeBuilder<Radio>(styles: styles).generate(),
      dialogTheme: ThemeBuilder<Dialog>(styles: styles).generate(),
      drawerTheme: ThemeBuilder<Drawer>(styles: styles).generate(),
      sliderTheme: ThemeBuilder<Slider>(styles: styles).generate(),
      switchTheme: ThemeBuilder<Switch>(styles: styles).generate(),
      tabBarTheme: ThemeBuilder<TabBar>(styles: styles).generate(),
      listTileTheme: ThemeBuilder<ListTile>(styles: styles).generate(),
      checkboxTheme: ThemeBuilder<Checkbox>(styles: styles).generate(),
      snackBarTheme: ThemeBuilder<SnackBar>(styles: styles).generate(),
      bottomSheetTheme: ThemeBuilder<BottomSheet>(styles: styles).generate(),
      expansionTileTheme:
          ThemeBuilder<ExpansionTile>(styles: styles).generate(),

      ///
      toggleButtonsTheme:
          ThemeBuilder<ToggleButtons>(styles: styles).generate(),
      progressIndicatorTheme:
          ThemeBuilder<ProgressIndicator>(styles: styles).generate(),
      floatingActionButtonTheme:
          ThemeBuilder<FloatingActionButton>(styles: styles).generate(),
      colorScheme: mainStyle.colorScheme(),
    );
  }

  Color primaryColor() {
    return getTheme().primaryColor;
  }

  ThemeData getTheme() {
    return themeMode == ThemeMode.light ? lightTheme : darkTheme;
  }

  bool changePrimaryColor() {
    return true;
  }

  Style defaultLightStyle() {
    return Style(
      mode: ThemeMode.light,
      primary: Colors.red,
    );
  }

  Style defaultDarkStyle() {
    return Style(mode: ThemeMode.dark, primary: Colors.blueAccent);
  }
}
