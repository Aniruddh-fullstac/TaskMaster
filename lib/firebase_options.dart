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
    apiKey: 'AIzaSyBxohxWF-RhnPqTFQ7lcEC0-BMhnpsm6TQ',
    appId: '1:21548054186:web:e9cc302524ab4f533902d3',
    messagingSenderId: '21548054186',
    projectId: 'my-project-6a0c8',
    authDomain: 'my-project-6a0c8.firebaseapp.com',
    databaseURL: 'https://my-project-6a0c8-default-rtdb.firebaseio.com',
    storageBucket: 'my-project-6a0c8.appspot.com',
    measurementId: 'G-G701QE0H7Z',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB6Sh1jK5AwJlXSbe_bj_veC-jm2AEMcNM',
    appId: '1:21548054186:android:ccdf5b4d8f27c7e03902d3',
    messagingSenderId: '21548054186',
    projectId: 'my-project-6a0c8',
    databaseURL: 'https://my-project-6a0c8-default-rtdb.firebaseio.com',
    storageBucket: 'my-project-6a0c8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA8L1tE8ByrgVT3kU2bmuVZh8PYhQs6Unc',
    appId: '1:21548054186:ios:615a7c57caab52583902d3',
    messagingSenderId: '21548054186',
    projectId: 'my-project-6a0c8',
    databaseURL: 'https://my-project-6a0c8-default-rtdb.firebaseio.com',
    storageBucket: 'my-project-6a0c8.appspot.com',
    iosBundleId: 'com.example.todoApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA8L1tE8ByrgVT3kU2bmuVZh8PYhQs6Unc',
    appId: '1:21548054186:ios:db339849971cccd33902d3',
    messagingSenderId: '21548054186',
    projectId: 'my-project-6a0c8',
    databaseURL: 'https://my-project-6a0c8-default-rtdb.firebaseio.com',
    storageBucket: 'my-project-6a0c8.appspot.com',
    iosBundleId: 'com.example.todoApp.RunnerTests',
  );
}