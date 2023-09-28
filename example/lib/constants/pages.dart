import 'package:documentation/Pages/home_page.dart';
import 'package:flower/flower.dart';

List<FlowerPage<dynamic>>? pages = [
  FlowerPage(
    name: "/",
    page: () => const HomePage(),
  )
];
