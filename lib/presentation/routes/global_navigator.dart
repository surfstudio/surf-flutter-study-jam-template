import 'package:flutter/material.dart';
import 'package:surf_practice_chat_flutter/presentation/factories/screen_factory.dart';
import 'package:surf_practice_chat_flutter/presentation/widgets/not_found_page.dart';

class GlobalNavigationRoutes {
  static const splash = "/";
  static const login = "/login";
  static const main = "/main";
}

class GlobalNavigator {
  static final ScreenFactory _factory = ScreenFactory();

  static Map<String, WidgetBuilder> getAll() => _routes;

  static final Map<String, WidgetBuilder> _routes = {
    GlobalNavigationRoutes.splash: (_) => _factory.buildSplash(),
    GlobalNavigationRoutes.main: (_) => _factory.buildMain(),
  };

  static Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      default:
        return MaterialPageRoute(builder: (context) => const NotFoundPage());
    }
  }
}
