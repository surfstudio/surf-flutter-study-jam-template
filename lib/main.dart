import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/common/global_constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:surf_practice_chat_flutter/config/app_configuration.dart';
import 'package:surf_practice_chat_flutter/config/app_launcher.dart';
import 'package:surf_practice_chat_flutter/config/localize_helper.dart';
import 'package:surf_practice_chat_flutter/data/chat/repository/firebase.dart';
import 'package:surf_practice_chat_flutter/firebase_options.dart';
import 'package:surf_practice_chat_flutter/presentation/viewmodels/main_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var brightness = SchedulerBinding.instance!.window.platformBrightness;

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform(
      androidKey: GlobalConstants.androidKey,
      iosKey: GlobalConstants.iosKey,
      webKey: GlobalConstants.webKey,
    ),
  );

  //region Repositories
  final chatRepository = ChatRepositoryFirebase(FirebaseFirestore.instance);
  //endregion

  runApp(MultiProvider(
    providers: [
      Provider(create: (_) => chatRepository),
      ChangeNotifierProvider(
        create: (_) => MainViewModel(chatRepository),
      ),
      ChangeNotifierProvider(
          lazy: false,
          create: (_) =>
              AppConfiguration(isDarkTheme: brightness == Brightness.dark)),
      ChangeNotifierProvider(
        lazy: false,
        create: (_) => LocalizeHelper(const Locale("ru", "RU")),
      ),
    ],
    child: const AppLauncher(isDebug: false),
  ));
}
