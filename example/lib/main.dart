import 'package:documentation/constants/pages.dart';
import 'package:flower/flower.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(FlowerApp(
    title: "Flower Documentation",
    pages: pages,
    initialRoute: "/",
  ));
}
