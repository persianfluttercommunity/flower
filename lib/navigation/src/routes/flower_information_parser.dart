import 'package:flower/flower.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class FlowerInformationParser extends RouteInformationParser<RouteDecoder> {
  final String initialRoute;

  FlowerInformationParser({
    required this.initialRoute,
  }) {
    Flower.log('FlowerInformationParser is created !');
  }
  @override
  SynchronousFuture<RouteDecoder> parseRouteInformation(
    RouteInformation routeInformation,
  ) {
    var location = routeInformation.location;
    if (location == '/') {
      //check if there is a corresponding page
      //if not, relocate to initialRoute
      if (!(Flower.rootController.routerDelegate as FlowerDelegate)
          .registeredRoutes
          .any((element) => element.name == '/')) {
        location = initialRoute;
      }
    }

    Flower.log('FlowerInformationParser: route location: $location');

    final routeName = location;

    return SynchronousFuture(RouteDecoder.fromRoute(routeName));
  }

  @override
  RouteInformation restoreRouteInformation(RouteDecoder configuration) {
    return RouteInformation(
      location: configuration.pageSettings?.name,
      state: null,
    );
  }
}
