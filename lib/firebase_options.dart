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
    apiKey: 'AIzaSyAvMUuL5QbfqtLbmo8Tsw7t5FiNLQEtJ_k',
    appId: '1:285709959137:web:dbe8f2b439018ece371ca0',
    messagingSenderId: '285709959137',
    projectId: 'eleosgym',
    authDomain: 'eleosgym.firebaseapp.com',
    storageBucket: 'eleosgym.appspot.com',
    measurementId: 'G-TKPTZWRXYC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCn8ekCoKCu91VDQHIvXJQYEh3nLzWYfP4',
    appId: '1:285709959137:android:7a8c626692101bdc371ca0',
    messagingSenderId: '285709959137',
    projectId: 'eleosgym',
    storageBucket: 'eleosgym.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBFZXdIFO4cjOU96HBCiC5B80SEJi3LHNc',
    appId: '1:285709959137:ios:2f9b2dd70ad001f8371ca0',
    messagingSenderId: '285709959137',
    projectId: 'eleosgym',
    storageBucket: 'eleosgym.appspot.com',
    androidClientId: '285709959137-1o2ql9bld00bfhum6kc32ii05v6v9ne6.apps.googleusercontent.com',
    iosClientId: '285709959137-6qk7nl81coatc7pqee9vujfu540kbla8.apps.googleusercontent.com',
    iosBundleId: 'com.example.todoTest',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBFZXdIFO4cjOU96HBCiC5B80SEJi3LHNc',
    appId: '1:285709959137:ios:2f9b2dd70ad001f8371ca0',
    messagingSenderId: '285709959137',
    projectId: 'eleosgym',
    storageBucket: 'eleosgym.appspot.com',
    androidClientId: '285709959137-1o2ql9bld00bfhum6kc32ii05v6v9ne6.apps.googleusercontent.com',
    iosClientId: '285709959137-6qk7nl81coatc7pqee9vujfu540kbla8.apps.googleusercontent.com',
    iosBundleId: 'com.example.todoTest',
  );
}
