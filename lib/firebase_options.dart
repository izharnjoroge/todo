// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCorA6kpKJgvcmmtFb2D-ni2OG_HY2nQZo',
    appId: '1:591036472688:web:db953d88959f8747dac3b5',
    messagingSenderId: '591036472688',
    projectId: 'tasks-b65ea',
    authDomain: 'tasks-b65ea.firebaseapp.com',
    storageBucket: 'tasks-b65ea.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBG6yn-kvYYugOeiegjetijc397Gir_IJ4',
    appId: '1:591036472688:android:60804fe3d63e1ab0dac3b5',
    messagingSenderId: '591036472688',
    projectId: 'tasks-b65ea',
    storageBucket: 'tasks-b65ea.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDM51h3YEtN9co6Ctvwlkd62uWwNb46DWE',
    appId: '1:591036472688:ios:fa0601a58f474697dac3b5',
    messagingSenderId: '591036472688',
    projectId: 'tasks-b65ea',
    storageBucket: 'tasks-b65ea.appspot.com',
    iosClientId: '591036472688-g9i1dhkk2tqlu1d6dg0r38klpvgg7md1.apps.googleusercontent.com',
    iosBundleId: 'com.example.tasks',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDM51h3YEtN9co6Ctvwlkd62uWwNb46DWE',
    appId: '1:591036472688:ios:fa0601a58f474697dac3b5',
    messagingSenderId: '591036472688',
    projectId: 'tasks-b65ea',
    storageBucket: 'tasks-b65ea.appspot.com',
    iosClientId: '591036472688-g9i1dhkk2tqlu1d6dg0r38klpvgg7md1.apps.googleusercontent.com',
    iosBundleId: 'com.example.tasks',
  );
}
