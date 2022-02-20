import 'dart:async';

import 'package:core/common/app_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_practice_chat_flutter/config/app_configuration.dart';
import 'package:surf_practice_chat_flutter/config/localize_helper.dart';
import 'package:surf_practice_chat_flutter/presentation/routes/global_navigator.dart';

class SplashViewModel {
  String route = GlobalNavigationRoutes.login;
  final BuildContext context;
  late final LocalizeHelper localizeHelper;
  late final AppConfiguration appConfiguration;

  SplashViewModel(this.context) {
    _initAsync();
  }

  Future<void> _initAsync() async {
    await SharedPrefManager.init();
    appConfiguration = context.read<AppConfiguration>();
    localizeHelper = context.read<LocalizeHelper>();
    await localizeHelper.updateLocale();
    await appConfiguration.updateNetworkConnectionStatus();
    await _onNextPage();
  }

  Future<void> _onNextPage() async {
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, GlobalNavigationRoutes.main);
    });
  }
}
