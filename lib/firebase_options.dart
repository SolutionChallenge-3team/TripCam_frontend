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
    apiKey: 'AIzaSyBPc8pDdST5mC0oi-P3mybQimQgxqGT0LI',
    appId: '1:438050670265:web:3b72b05b807bb61354fd68',
    messagingSenderId: '438050670265',
    projectId: 'tripcam-6bb9b',
    authDomain: 'tripcam-6bb9b.firebaseapp.com',
    storageBucket: 'tripcam-6bb9b.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBmlfUp-g_p15c19fZzsyoqrjVxFcRu5fo',
    appId: '1:438050670265:android:11ead20af3dadc3254fd68',
    messagingSenderId: '438050670265',
    projectId: 'tripcam-6bb9b',
    storageBucket: 'tripcam-6bb9b.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDIQeyNj_EzrhZTR3ewlZNYQSAK7LODuRg',
    appId: '1:438050670265:ios:86149ded46eae0c054fd68',
    messagingSenderId: '438050670265',
    projectId: 'tripcam-6bb9b',
    storageBucket: 'tripcam-6bb9b.firebasestorage.app',
    iosBundleId: 'com.example.tripcam',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDIQeyNj_EzrhZTR3ewlZNYQSAK7LODuRg',
    appId: '1:438050670265:ios:86149ded46eae0c054fd68',
    messagingSenderId: '438050670265',
    projectId: 'tripcam-6bb9b',
    storageBucket: 'tripcam-6bb9b.firebasestorage.app',
    iosBundleId: 'com.example.tripcam',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBPc8pDdST5mC0oi-P3mybQimQgxqGT0LI',
    appId: '1:438050670265:web:b02617140d75cbbd54fd68',
    messagingSenderId: '438050670265',
    projectId: 'tripcam-6bb9b',
    authDomain: 'tripcam-6bb9b.firebaseapp.com',
    storageBucket: 'tripcam-6bb9b.firebasestorage.app',
  );

}