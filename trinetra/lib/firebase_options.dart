// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyD5KvIgucKIX5eQLu2BVR67xMHrXgg7IEs',
    appId: '1:690939877907:web:6c4495804216396fd3bde6',
    messagingSenderId: '690939877907',
    projectId: 'trinetra-8fcf3',
    authDomain: 'trinetra-8fcf3.firebaseapp.com',
    storageBucket: 'trinetra-8fcf3.firebasestorage.app',
    measurementId: 'G-46DE8PPRL1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCJebUPP0A2mF8JOTraeWAq-IoIs0sYvUw',
    appId: '1:690939877907:android:35f8aae643f6317cd3bde6',
    messagingSenderId: '690939877907',
    projectId: 'trinetra-8fcf3',
    storageBucket: 'trinetra-8fcf3.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA-p7OweKzGfkTJRJUGFo9WuD4JtlxqV5s',
    appId: '1:690939877907:ios:7994dbbb01369a8bd3bde6',
    messagingSenderId: '690939877907',
    projectId: 'trinetra-8fcf3',
    storageBucket: 'trinetra-8fcf3.firebasestorage.app',
    iosBundleId: 'com.example.trinetraflutter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA-p7OweKzGfkTJRJUGFo9WuD4JtlxqV5s',
    appId: '1:690939877907:ios:7994dbbb01369a8bd3bde6',
    messagingSenderId: '690939877907',
    projectId: 'trinetra-8fcf3',
    storageBucket: 'trinetra-8fcf3.firebasestorage.app',
    iosBundleId: 'com.example.trinetraflutter',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD5KvIgucKIX5eQLu2BVR67xMHrXgg7IEs',
    appId: '1:690939877907:web:07b03bfda1915cdbd3bde6',
    messagingSenderId: '690939877907',
    projectId: 'trinetra-8fcf3',
    authDomain: 'trinetra-8fcf3.firebaseapp.com',
    storageBucket: 'trinetra-8fcf3.firebasestorage.app',
    measurementId: 'G-3DDG7X0LQF',
  );
}