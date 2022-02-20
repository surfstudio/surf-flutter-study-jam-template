import 'package:core/common/app_preferences.dart';
import 'package:core/common/global_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_practice_chat_flutter/config/app_configuration.dart';
import 'package:surf_practice_chat_flutter/config/localization.dart';
import 'package:surf_practice_chat_flutter/config/localize_helper.dart';
import 'package:surf_practice_chat_flutter/presentation/routes/global_navigator.dart';

class AppLauncher extends StatefulWidget {
  final bool isDebug;

  const AppLauncher({Key? key, this.isDebug = false}) : super(key: key);

  @override
  _AppLauncherState createState() => _AppLauncherState();
}

class _AppLauncherState extends State<AppLauncher> {
  @override
  Widget build(BuildContext context) {
    var config = context.watch<AppConfiguration>();
    var localizeHelper = context.watch<LocalizeHelper>();
    return MaterialApp(
      supportedLocales: Localization.supportedLocales,
      locale: localizeHelper.locale,
      localizationsDelegates: localizeHelper.localizationsDelegates,
      localeResolutionCallback: _localeResolutionCallback,
      theme: config.currentTheme,
      initialRoute: config.initialRoute,
      debugShowCheckedModeBanner: widget.isDebug,
      routes: GlobalNavigator.getAll(),
      onGenerateRoute: GlobalNavigator.onGenerateRoute,
    );
  }

  Locale? _localeResolutionCallback(
      Locale? deviceLocal, Iterable<Locale?>? supportedLocals) {
    if (deviceLocal == null || supportedLocals == null) {
      return null;
    }
    for (var local in supportedLocals) {
      if (local?.languageCode == deviceLocal.languageCode &&
          local?.countryCode == deviceLocal.countryCode) {
        return local;
      }
    }
    return supportedLocals.first;
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    await SharedPrefManager.init();
    var config = context.read<AppConfiguration>();
    var isDarkTheme = SharedPrefManager.getBool(GlobalConstants.isDarkThemeKey);
    isDarkTheme = (isDarkTheme != null && isDarkTheme == true);
    config.setTheme(isDarkTheme);
  }
}
