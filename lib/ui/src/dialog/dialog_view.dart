import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class DialogView extends StatelessWidget {
  const DialogView({
    Key? key,
    required this.child,
    this.title,
    this.closeButton,
    this.leftBar,
    this.rightBar,
    this.onClose,
    this.fullScreen = false,
    this.direction = TextDirection.ltr,
    this.width,
    this.height,
    this.radius,
    this.backgroundColor,
    this.borderColor,
  }) : super(key: key);

  /// size that determine dialog size
  // final Size? size;

  final double? width;
  final double? height;
  final double? radius;

  final Color? backgroundColor;
  final Color? borderColor;

  /// dialog title that placed on center top of dialog
  final String? title;

  /// action buttons that placed on top left of dialog
  final List<Widget>? leftBar;

  /// action buttons that placed on top right of dialog
  final List<Widget>? rightBar;

  /// a boolean determine that dialog has close button or not
  final bool? closeButton;

  /// a widghet that placed in center of dialog as child
  final Widget child;

  /// a boolean determine that dialog is fullscreen or not
  final bool fullScreen;

  /// determine direction of dialog
  final TextDirection direction;

  /// optional configuration of glass effects
  // final GlassyConfig? config;

  /// dialog close callback
  final Function()? onClose;

  /// on dialog close callback
  // final DialogConfig config;

  /// function that determines final dialog size
  // Size dialogSize(BuildContext context) {
  //   if (size != null) {
  //     return size!;
  //   } else {
  //     return Size(min(MediaQuery.of(context).size.width * 0.95, 400),
  //         min(MediaQuery.of(context).size.width * 0.95, 400));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
        child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      child: Dialog(
        insetPadding: fullScreen
            ? EdgeInsets.zero
            : const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: borderColor ?? Colors.black26),
          borderRadius: BorderRadius.circular(fullScreen ? 0 : radius ?? 5),
        ),
        child: Container(
          width: width ?? min(MediaQuery.of(context).size.width * 0.95, 400),
          height: height != null
              ? min(MediaQuery.of(context).size.height * 0.8, height!)
              : null,
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              Row(
                children: [
                  if (closeButton == null || closeButton == true)
                    IconButton(
                      icon: Icon(
                        Icons.clear,
                        // color: (config ?? glassyConfig).foregroundColor,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        if (onClose != null) {
                          onClose!();
                        }
                      },
                    ),
                  if (rightBar != null)
                    Row(
                      children: rightBar!,
                    ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          title == null ? " " : title!,
                          style: TextStyle(
                            fontSize: 20,
                            // color: (config ?? glassyConfig)
                            //     .foregroundColor
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (leftBar != null)
                    Row(
                      children: leftBar!,
                    ),
                ],
              ),
              Expanded(child: child)
            ],
          ),
        ),
      ),
    ));
  }
}
