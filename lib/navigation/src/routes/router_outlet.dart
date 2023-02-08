import 'package:flower/flower.dart';
import 'package:flutter/material.dart';

// import '../../../get.dart';

class RouterOutlet<TDelegate extends RouterDelegate<T>, T extends Object>
    extends StatefulWidget {
  final TDelegate routerDelegate;
  final Widget Function(BuildContext context) builder;

  //keys
  RouterOutlet.builder({
    TDelegate? delegate,
    required this.builder,
  })  : routerDelegate = delegate ?? Flower.delegate<TDelegate, T>()!,
        super();

  RouterOutlet({
    TDelegate? delegate,
    required Iterable<FlowerPage> Function(T currentNavStack) pickPages,
    required Widget Function(
      BuildContext context,
      TDelegate,
      Iterable<FlowerPage>? page,
    )
        pageBuilder,
  }) : this.builder(
          builder: (context) {
            final currentConfig = context.delegate.currentConfiguration as T?;
            final rDelegate = context.delegate as TDelegate;
            var picked =
                currentConfig == null ? null : pickPages(currentConfig);
            if (picked?.isEmpty ?? true) {
              picked = null;
            }
            return pageBuilder(context, rDelegate, picked);
          },
          delegate: delegate,
        );
  @override
  _RouterOutletState<TDelegate, T> createState() =>
      _RouterOutletState<TDelegate, T>();
}

class _RouterOutletState<TDelegate extends RouterDelegate<T>, T extends Object>
    extends State<RouterOutlet<TDelegate, T>> {
  RouterDelegate? delegate;
  late ChildBackButtonDispatcher _backButtonDispatcher;

  void _listener() {
    setState(() {});
  }

  VoidCallback? disposer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    disposer?.call();
    final router = Router.of(context);
    delegate ??= router.routerDelegate;
    delegate?.addListener(_listener);
    disposer = () => delegate?.removeListener(_listener);

    _backButtonDispatcher =
        router.backButtonDispatcher!.createChildBackButtonDispatcher();
  }

  @override
  void dispose() {
    super.dispose();
    disposer?.call();
    // Get.routerDelegate?.removeListener(_listener);
    //_backButtonDispatcher.forget(_backButtonDispatcher)
  }

  @override
  Widget build(BuildContext context) {
    _backButtonDispatcher.takePriority();
    return widget.builder(context);
  }
}

// class _RouterOutletState<TDelegate extends RouterDelegate<T>,
//T extends Object>
//     extends State<RouterOutlet<TDelegate, T>> {
//   TDelegate get delegate => context.delegate as TDelegate;
//   @override
//   void initState() {
//     super.initState();
//   }

//   VoidCallback? disposer;

//   @override
//   void didChangeDependencies() {
//     disposer?.call();
//     delegate.addListener(onRouterDelegateChanged);
//     disposer = () => delegate.removeListener(onRouterDelegateChanged);
//     _getCurrentRoute();
//     super.didChangeDependencies();
//   }

//   @override
//   void dispose() {
//     disposer?.call();
//     super.dispose();
//   }

//   T? currentRoute;
//   void _getCurrentRoute() {
//     currentRoute = delegate.currentConfiguration;
//   }

//   void onRouterDelegateChanged() {
//     setState(_getCurrentRoute);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return widget.builder(context);
//   }
// }

class GetRouterOutlet extends RouterOutlet<FlowerDelegate, RouteDecoder> {
  GetRouterOutlet({
    String? anchorRoute,
    required String initialRoute,
    Iterable<FlowerPage> Function(Iterable<FlowerPage> afterAnchor)?
        filterPages,
    // GlobalKey<NavigatorState>? key,
    FlowerDelegate? delegate,
  }) : this.pickPages(
          pickPages: (config) {
            Iterable<FlowerPage<dynamic>> ret;
            if (anchorRoute == null) {
              // jump the ancestor path
              final length = Uri.parse(initialRoute).pathSegments.length;

              return config.currentTreeBranch
                  .skip(length)
                  .take(length)
                  .toList();
            }
            ret = config.currentTreeBranch.pickAfterRoute(anchorRoute);
            if (filterPages != null) {
              ret = filterPages(ret);
            }
            return ret;
          },
          emptyPage: (delegate) =>
              delegate.matchRoute(initialRoute).route ?? delegate.notFoundRoute,
          key: Flower.nestedKey(anchorRoute)?.navigatorKey,
          delegate: delegate,
        );
  GetRouterOutlet.pickPages({
    Widget Function(FlowerDelegate delegate)? emptyWidget,
    FlowerPage Function(FlowerDelegate delegate)? emptyPage,
    required Iterable<FlowerPage> Function(RouteDecoder currentNavStack)
        pickPages,
    bool Function(Route<dynamic>, dynamic)? onPopPage,
    GlobalKey<NavigatorState>? key,
    FlowerDelegate? delegate,
  }) : super(
          pageBuilder: (context, rDelegate, pages) {
            final pageRes = <FlowerPage?>[
              ...?pages,
              if (pages == null || pages.isEmpty) emptyPage?.call(rDelegate),
            ].whereType<FlowerPage>();

            if (pageRes.isNotEmpty) {
              return FlowerNavigator(
                onPopPage: onPopPage ??
                    (route, result) {
                      final didPop = route.didPop(result);
                      if (!didPop) {
                        return false;
                      }
                      return true;
                    },
                pages: pageRes.toList(),
                key: key,
              );
            }
            return (emptyWidget?.call(rDelegate) ?? SizedBox.shrink());
          },
          pickPages: pickPages,
          delegate: delegate ?? Flower.rootController.rootDelegate,
        );

  GetRouterOutlet.builder({
    required Widget Function(
      BuildContext context,
    )
        builder,
    FlowerDelegate? routerDelegate,
  }) : super.builder(
          builder: builder,
          delegate: routerDelegate,
        );
}

extension PagesListExt on List<FlowerPage> {
  Iterable<FlowerPage> pickAtRoute(String route) {
    return skipWhile((value) {
      return value.name != route;
    });
  }

  Iterable<FlowerPage> pickAfterRoute(String route) {
    return pickAtRoute(route).skip(1);
  }
}
