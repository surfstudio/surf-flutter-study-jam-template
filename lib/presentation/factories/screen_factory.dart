import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_practice_chat_flutter/presentation/screens/main_screen.dart';
import 'package:surf_practice_chat_flutter/presentation/screens/splash_screen.dart';
import 'package:surf_practice_chat_flutter/presentation/viewmodels/splash_view_model.dart';

class ScreenFactory {
  Widget buildSplash() {
    return Provider(
        lazy: false,
        create: (context) => SplashViewModel(context),
        child: const SplashScreen());
  }

  Widget buildMain() {
    return const MainScreen();
  }
}
