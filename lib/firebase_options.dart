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
    apiKey: 'AIzaSyBOY3cZ8aHryfABoupKSxLgE1mceuBt3J0',
    appId: '1:416666473805:web:99d607bfa8dc6a1e661304',
    messagingSenderId: '416666473805',
    projectId: 'petcare-1dc9f',
    authDomain: 'petcare-1dc9f.firebaseapp.com',
    storageBucket: 'petcare-1dc9f.firebasestorage.app',
    measurementId: 'G-FN6XVZ4GF0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD1F6V5Zm84d7fQ3wjwsEl229Gq8NqgoG8',
    appId: '1:416666473805:android:06cd1f484997d7fa661304',
    messagingSenderId: '416666473805',
    projectId: 'petcare-1dc9f',
    storageBucket: 'petcare-1dc9f.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCnktvG1IsWgR4n2vEWfW200abFveu-jPI',
    appId: '1:416666473805:ios:9ff03c7507aeca2b661304',
    messagingSenderId: '416666473805',
    projectId: 'petcare-1dc9f',
    storageBucket: 'petcare-1dc9f.firebasestorage.app',
    iosBundleId: 'com.example.petCare',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCnktvG1IsWgR4n2vEWfW200abFveu-jPI',
    appId: '1:416666473805:ios:9ff03c7507aeca2b661304',
    messagingSenderId: '416666473805',
    projectId: 'petcare-1dc9f',
    storageBucket: 'petcare-1dc9f.firebasestorage.app',
    iosBundleId: 'com.example.petCare',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBOY3cZ8aHryfABoupKSxLgE1mceuBt3J0',
    appId: '1:416666473805:web:808bdf8990d1eba6661304',
    messagingSenderId: '416666473805',
    projectId: 'petcare-1dc9f',
    authDomain: 'petcare-1dc9f.firebaseapp.com',
    storageBucket: 'petcare-1dc9f.firebasestorage.app',
    measurementId: 'G-0FB9ZKMR51',
  );
}
