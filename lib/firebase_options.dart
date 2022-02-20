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
        appId: '1:319442930124:web:8b79dbba14f7e1efb73569',
        messagingSenderId: '319442930124',
        projectId: 'flutter-study-jam-chat-eb42c',
        authDomain: 'flutter-study-jam-chat-eb42c.firebaseapp.com',
        storageBucket: 'flutter-study-jam-chat-eb42c.appspot.com',
      );

  static FirebaseOptions android(String apiKey) => FirebaseOptions(
        apiKey: apiKey,
        appId: '1:319442930124:android:bbeb0c0b03096fbfb73569',
        messagingSenderId: '319442930124',
        projectId: 'flutter-study-jam-chat-eb42c',
        storageBucket: 'flutter-study-jam-chat-eb42c.appspot.com',
      );

  static FirebaseOptions ios(String apiKey) => FirebaseOptions(
        apiKey: apiKey,
        appId: '1:319442930124:ios:077f791e04efe28db73569',
        messagingSenderId: '319442930124',
        projectId: 'flutter-study-jam-chat-eb42c',
        storageBucket: 'flutter-study-jam-chat-eb42c.appspot.com',
        iosClientId:
            '319442930124-fj7fp4v2asmmfcoghp4b6d7l8ibo6n1u.apps.googleusercontent.com',
        iosBundleId: 'com.example.surfPracticeChatFlutter',
      );
}
