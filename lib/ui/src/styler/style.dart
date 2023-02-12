import 'package:flutter/material.dart';

class Style {
  ThemeMode mode;
  StyleTag tag = StyleTag.all;

  /// ----------------------- Colors
  Color? background;
  Color? primary;
  Color? foreground;
  Color? border;
  Color? secondary;
  Color? shadow;
  Color? surfaceTint;
  double? opacity;

  ///
  double? borderRadius;
  double? borderWidth;
  EdgeInsets? padding;
  EdgeInsets? margin;
  double? elevation;

  AlignmentGeometry? alignment;

  /// ---------------------- Text Style
  String? fontFamily;
  double? fontSize;
  double? fontWeight;
  TextAlign? textAlign;

  /// ---------------------- Sizing
  double? size;
  double? width;
  double? height;
  double? maxWidth;
  double? maxHeight;

  ///
  double? blur;

  Style(
      {required this.mode,
      this.tag = StyleTag.all,
      this.borderRadius = 8.0,
      this.borderWidth = 1.0,
      this.padding,
      this.fontFamily,
      this.fontSize,
      this.fontWeight,
      this.background,
      this.primary,
      this.foreground,
      this.border,
      this.secondary}) {}

  ColorScheme colorScheme() {
    ColorScheme scheme = mode == ThemeMode.light
        ? const ColorScheme.light()
        : const ColorScheme.dark();

    return scheme.copyWith(
      background: background,
      primary: primary,
      onBackground: foreground,
      outline: border,
      secondary: secondary,
      shadow: shadow,
    );
  }

  void merge(Style newStyle) {
    background = newStyle.background ?? background;
    primary = newStyle.primary ?? primary;
    foreground = newStyle.foreground ?? foreground;
    border = newStyle.border ?? border;
    secondary = newStyle.secondary ?? secondary;
    shadow = newStyle.shadow ?? shadow;
    borderRadius = newStyle.borderRadius ?? borderRadius;
    borderWidth = newStyle.borderWidth ?? borderWidth;
    padding = newStyle.padding ?? padding;
    margin = newStyle.margin ?? margin;
    fontFamily = newStyle.fontFamily ?? fontFamily;
    fontSize = newStyle.fontSize ?? fontSize;
    fontWeight = newStyle.fontWeight ?? fontWeight;
    textAlign = newStyle.textAlign ?? textAlign;
    size = newStyle.size ?? size;
    maxWidth = newStyle.maxWidth ?? maxWidth;
    maxHeight = newStyle.maxHeight ?? maxHeight;
    blur = newStyle.blur ?? blur;
  }

  bool compareTags(List<StyleTag> tags) {
    return tags.any((element) => element == tag);
  }

  bool hasBorder() => (border != null || borderWidth != null);
  bool hasShape() => hasBorder() || borderRadius != null;

  ShapeBorder? shape() => hasShape()
      ? RoundedRectangleBorder(
          side: hasBorder()
              ? BorderSide(
                  color: border ?? colorScheme().background,
                  width: borderWidth!,
                )
              : BorderSide.none,
          borderRadius: BorderRadius.circular(borderRadius ?? 8), // <-- Radius
        )
      : null;

  TextStyle? textStyle() => TextStyle();
}

class DarkStyle extends Style {
  DarkStyle(
      {super.tag = StyleTag.all,
      super.borderRadius = 8.0,
      super.borderWidth = 1.0,
      super.padding,
      super.fontFamily,
      super.fontSize,
      super.fontWeight,
      super.background,
      super.primary,
      super.foreground,
      super.border,
      super.secondary})
      : super(mode: ThemeMode.dark);
}

class LightStyle extends Style {
  LightStyle(
      {super.tag = StyleTag.main,
      super.borderRadius = 8.0,
      super.borderWidth = 1.0,
      super.padding,
      super.fontFamily,
      super.fontSize,
      super.fontWeight,
      super.background,
      super.primary,
      super.foreground,
      super.border,
      super.secondary})
      : super(mode: ThemeMode.light);
}

enum StyleTag {
  main,
  all,
  appBar,
  button,
  textButton,
  elevatedButton,

  card,
  textField,
  icon,
  text,
  radio,
  drawer,
  slider,
  tabBar,
  listTile,
  checkBox,
  snackBar,
  bottomSheet,
  expansionTile,
  toggleButton,
  progressIndicator,
  fab,
}
