import 'package:flower/flower.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ConfigData {
  final ValueChanged<Routing?>? routingCallback;
  final Transition? defaultTransition;
  final bool? opaqueRoute;
  final VoidCallback? onInit;
  final VoidCallback? onReady;
  final VoidCallback? onDispose;
  final bool? enableLog;
  final Logger? logWriterCallback;
  final bool? popGesture;
  final SmartManagement smartManagement;
  final List<Bind> binds;
  final Duration? transitionDuration;
  final bool? defaultGlobalState;
  final List<FlowerPage>? flowerPages;
  final FlowerPage? unknownRoute;
  final RouteInformationProvider? routeInformationProvider;
  final RouteInformationParser<Object>? routeInformationParser;
  final RouterDelegate<Object>? routerDelegate;
  final BackButtonDispatcher? backButtonDispatcher;
  final List<NavigatorObserver>? navigatorObservers;
  final GlobalKey<NavigatorState>? navigatorKey;
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;
  final Map<String, Map<String, String>>? translationsKeys;
  final Translations? translations;
  final Locale? locale;
  final Locale? fallbackLocale;
  final String? initialRoute;
  final CustomTransition? customTransition;
  final Widget? home;

  final Color? primaryColor;

  ConfigData({
    required this.routingCallback,
    required this.defaultTransition,
    required this.opaqueRoute,
    required this.onInit,
    required this.onReady,
    required this.onDispose,
    required this.enableLog,
    required this.logWriterCallback,
    required this.popGesture,
    required this.smartManagement,
    required this.binds,
    required this.transitionDuration,
    required this.defaultGlobalState,
    required this.flowerPages,
    required this.unknownRoute,
    required this.routeInformationProvider,
    required this.routeInformationParser,
    required this.routerDelegate,
    required this.backButtonDispatcher,
    required this.navigatorObservers,
    required this.navigatorKey,
    required this.scaffoldMessengerKey,
    required this.translationsKeys,
    required this.translations,
    required this.locale,
    required this.fallbackLocale,
    required this.initialRoute,
    required this.customTransition,
    required this.home,
    this.primaryColor,
  });
}

class FlowerController extends FullLifeCycleController {
  FlowerController(this.config, this.uiConfig);

  final _box = Storage();

  static FlowerController get to {
    return Flower.find();
  }

  late final RouterDelegate<Object>? routerDelegate;
  late final RouteInformationParser<Object> routeInformationParser;
  final ConfigData config;
  final UIConfig uiConfig;

  @override
  void onReady() {
    config.onReady?.call();
    super.onReady();
  }

  @override
  void onInit() {
    super.onInit();

    if (config.flowerPages == null && config.home == null) {
      throw 'You need add pages or home';
    }

    routerDelegate = config.routerDelegate ??
        createDelegate(
          pages: config.flowerPages ??
              [
                FlowerPage(
                  name: cleanRouteName("/${config.home.runtimeType}"),
                  page: () => config.home!,
                ),
              ],
          notFoundRoute: config.unknownRoute,
          navigatorKey: config.navigatorKey,
          navigatorObservers: (config.navigatorObservers == null
              ? <NavigatorObserver>[
                  FlowerObserver(config.routingCallback, Flower.routing)
                ]
              : <NavigatorObserver>[
                  FlowerObserver(config.routingCallback, routing),
                  ...config.navigatorObservers!
                ]),
        );

    routeInformationParser = config.routeInformationParser ??
        createInformationParser(
          initialRoute: config.initialRoute ??
              config.flowerPages?.first.name ??
              cleanRouteName("/${config.home.runtimeType}"),
        );

    if (config.locale != null) Flower.locale = config.locale;

    if (config.fallbackLocale != null) {
      Flower.fallbackLocale = config.fallbackLocale;
    }

    if (config.translations != null) {
      Flower.addTranslations(config.translations!.keys);
    } else if (config.translationsKeys != null) {
      Flower.addTranslations(config.translationsKeys!);
    }

    customTransition = config.customTransition;

    //Flower.setDefaultDelegate(routerDelegate);
    Flower.smartManagement = config.smartManagement;
    config.onInit?.call();

    Flower.isLogEnable = config.enableLog ?? kDebugMode;
    Flower.log = config.logWriterCallback ?? defaultLogger;
    defaultTransition = config.defaultTransition;
    defaultOpaqueRoute = config.opaqueRoute ?? true;
    defaultPopGesture = config.popGesture ?? FlowerPlatform.isIOS;
    defaultTransitionDuration =
        config.transitionDuration ?? const Duration(milliseconds: 300);

    // defaultTransitionCurve = Curves.easeOutQuad;
    // defaultDialogTransitionCurve = Curves.easeOutQuad;
    // defaultDialogTransitionDuration = Duration(milliseconds: 300);

    // theme = ThemeData(
    //     fontFamily: 'IranYekan',
    //     // elevatedButtonTheme: ElevatedButtonThemeData(
    //     //     style: ElevatedButton.styleFrom(
    //     //   foregroundColor: Colors.white,
    //     //   backgroundColor: const Color(0xE8212121),
    //     //   padding: const EdgeInsets.all(10.0),
    //     //   shape: RoundedRectangleBorder(
    //     //     borderRadius: BorderRadius.circular(10.0),
    //     //   ),
    //     // )),
    //     appBarTheme: AppBarTheme(
    //         backgroundColor: Colors.grey.shade200,
    //         foregroundColor: Colors.black54),
    //     colorScheme: ColorScheme.light(
    //       primary: _box.read<int>("primaryColor") != null
    //           ? Color(_box.read<int>("primaryColor")!)
    //           : (config.primaryColor ?? Colors.blue),
    //     ));

    // darkTheme = ThemeData(
    //     fontFamily: 'IranYekan',
    //     elevatedButtonTheme: ElevatedButtonThemeData(
    //         style: ElevatedButton.styleFrom(
    //       foregroundColor: Colors.white,
    //       backgroundColor: const Color(0xE8212121),
    //       padding: const EdgeInsets.all(10.0),
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(10.0),
    //       ),
    //     )),
    //     appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF282828)),
    //     colorScheme: ColorScheme.dark(
    //       primary: _box.read<int>("primaryColor") != null
    //           ? Color(_box.read<int>("primaryColor")!)
    //           : (config.primaryColor ?? Colors.blue),
    //     ));
  }

  String cleanRouteName(String name) {
    name = name.replaceAll('() => ', '');

    /// uncommonent for URL styling.
    // name = name.paramCase!;
    if (!name.startsWith('/')) {
      name = '/$name';
    }
    return Uri.tryParse(name)?.toString() ?? name;
  }

  bool testMode = false;
  Key? unikey;
  // ThemeData? theme;
  // ThemeData? darkTheme;
  // ThemeMode? themeMode;

  final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  bool defaultPopGesture = FlowerPlatform.isIOS;
  bool defaultOpaqueRoute = true;
  Transition? defaultTransition;
  Duration defaultTransitionDuration = const Duration(milliseconds: 300);
  Curve defaultTransitionCurve = Curves.easeOutQuad;
  Curve defaultDialogTransitionCurve = Curves.easeOutQuad;
  Duration defaultDialogTransitionDuration = const Duration(milliseconds: 300);

  final routing = Routing();

  Map<String, String?> parameters = {};
  CustomTransition? customTransition;

  Map<dynamic, FlowerDelegate> keys = {};

  GlobalKey<NavigatorState> get key => rootDelegate.navigatorKey;

  FlowerDelegate get rootDelegate => routerDelegate as FlowerDelegate;

  GlobalKey<NavigatorState>? addKey(GlobalKey<NavigatorState> newKey) {
    rootDelegate.navigatorKey = newKey;
    return key;
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    Flower.asap(() {
      final locale = Flower.deviceLocale;
      if (locale != null) {
        Flower.updateLocale(locale);
      }
    });
  }

  void restartApp() {
    unikey = UniqueKey();
    update();
  }

  void setTheme(ThemeData value) {
    if (uiConfig.darkTheme == null) {
      uiConfig.lightTheme = value;
    } else {
      if (value.brightness == Brightness.light) {
        uiConfig.lightTheme = value;
      } else {
        uiConfig.darkTheme = value;
      }
    }
    update();
  }

  void setThemeMode(ThemeMode value) {
    uiConfig.themeMode = value;
    update();
  }

  void toggleThemeMode() {
    uiConfig.themeMode = (uiConfig.themeMode == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark);
    update();
  }

  void changePrimaryColor(Color color) {
    _box.write("primaryColor", color.value);

    uiConfig.lightTheme = uiConfig.lightTheme.copyWith(
        colorScheme: ColorScheme.light(
      primary: color,
    ));
    uiConfig.darkTheme = uiConfig.darkTheme.copyWith(
        colorScheme: ColorScheme.dark(
      primary: color,
    ));
    update();
  }

  FlowerDelegate? nestedKey(String? key) {
    if (key == null) {
      return routerDelegate as FlowerDelegate;
    }
    keys.putIfAbsent(
      key,
      () => FlowerDelegate(
        showHashOnUrl: true,
        //debugLabel: 'Getx nested key: ${key.toString()}',
        pages: RouteDecoder.fromRoute(key).currentChildrens ?? [],
      ),
    );
    return keys[key];
  }

  FlowerInformationParser createInformationParser({String initialRoute = '/'}) {
    return FlowerInformationParser(
      initialRoute: initialRoute,
    );
  }

  // static GetDelegate? _delegate;

  FlowerDelegate createDelegate({
    FlowerPage<dynamic>? notFoundRoute,
    List<FlowerPage> pages = const [],
    List<NavigatorObserver>? navigatorObservers,
    TransitionDelegate<dynamic>? transitionDelegate,
    PopMode backButtonPopMode = PopMode.history,
    PreventDuplicateHandlingMode preventDuplicateHandlingMode =
        PreventDuplicateHandlingMode.reorderRoutes,
    GlobalKey<NavigatorState>? navigatorKey,
  }) {
    return FlowerDelegate(
      notFoundRoute: notFoundRoute,
      navigatorObservers: navigatorObservers,
      transitionDelegate: transitionDelegate,
      backButtonPopMode: backButtonPopMode,
      preventDuplicateHandlingMode: preventDuplicateHandlingMode,
      pages: pages,
      navigatorKey: navigatorKey,
    );
  }
}
