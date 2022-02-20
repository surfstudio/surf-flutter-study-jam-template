import 'dart:io';

import 'package:flutter/material.dart';
import 'package:surf_practice_chat_flutter/resources/styles.dart';

class AppConfiguration extends ChangeNotifier {
  bool isLoading = false;
  bool isDarkTheme = false;
  bool hasInternetConnection = false;
  late ThemeData currentTheme;
  final String initialRoute;

  AppConfiguration({required this.isDarkTheme, this.initialRoute = "/"}) {
    currentTheme = isDarkTheme ? Styles.darkTheme : Styles.defaultTheme;
  }

  void showLoading() {
    isLoading = true;
    notifyListeners();
  }

  void stopLoading() {
    isLoading = false;
    notifyListeners();
  }

  void setTheme(bool isDark) {
    isDarkTheme = isDark;
    currentTheme = isDark ? Styles.darkTheme : Styles.defaultTheme;
    notifyListeners();
  }

  Future<void> updateNetworkConnectionStatus() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasInternetConnection = true;
      }
    } on SocketException catch (_) {
      hasInternetConnection = false;
    } finally {
      notifyListeners();
    }
  }
}
