// ignore_for_file: lines_longer_than_80_chars
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions currentPlatform({
    required String webKey,
    required String iosKey,
    required String androidKey,
  }) {
    if (kIsWeb) {
      return web(webKey);
    }
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android(androidKey);
      case TargetPlatform.iOS:
        return ios(iosKey);
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static FirebaseOptions web(String apiKey) => FirebaseOptions(
        apiKey: apiKey,
        appId: '1:495369196783:web:e6fcda561e827d0e6b771a',
        messagingSenderId: '495369196783',
        projectId: 'flutter-study-jam-chat-f6f94',
        authDomain: 'flutter-study-jam-chat-f6f94.firebaseapp.com',
        storageBucket: 'flutter-study-jam-chat-f6f94.appspot.com',
      );

  static FirebaseOptions android(String apiKey) => FirebaseOptions(
        apiKey: apiKey,
        appId: '1:495369196783:android:7f0925fb1b46a0206b771a',
        messagingSenderId: '495369196783',
        projectId: 'flutter-study-jam-chat-f6f94',
        storageBucket: 'flutter-study-jam-chat-f6f94.appspot.com',
      );

  static FirebaseOptions ios(String apiKey) => FirebaseOptions(
        apiKey: apiKey,
        appId: '1:495369196783:ios:c2e9c649906e79166b771a',
        messagingSenderId: '495369196783',
        projectId: 'flutter-study-jam-chat-f6f94',
        storageBucket: 'flutter-study-jam-chat-f6f94.appspot.com',
        iosClientId:
            '495369196783-qj1a0ko1bmn2p0br6v4hn2dgs7nif9la.apps.googleusercontent.com',
        iosBundleId: 'com.example.surfPracticeChatFlutter',
      );
}
