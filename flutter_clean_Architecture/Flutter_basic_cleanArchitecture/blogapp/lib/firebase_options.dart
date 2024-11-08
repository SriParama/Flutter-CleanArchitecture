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
    apiKey: 'AIzaSyD-cXpcSBd7qt24_k4pGFi_DNzCMUgWIrQ',
    appId: '1:606882209979:web:0a8cd56e04c476f727499e',
    messagingSenderId: '606882209979',
    projectId: 'blogapp-665c6',
    authDomain: 'blogapp-665c6.firebaseapp.com',
    storageBucket: 'blogapp-665c6.appspot.com',
    measurementId: 'G-Z39LZYECKF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDDxqM60mUNdxmQNVciqZCavNIFbXyGKwo',
    appId: '1:606882209979:android:352f67a96e248c1027499e',
    messagingSenderId: '606882209979',
    projectId: 'blogapp-665c6',
    storageBucket: 'blogapp-665c6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBF6bRrNMhuy1x-Fv1Jmb6pNrGW-gjoXHo',
    appId: '1:606882209979:ios:05ec33c55ed89b6827499e',
    messagingSenderId: '606882209979',
    projectId: 'blogapp-665c6',
    storageBucket: 'blogapp-665c6.appspot.com',
    iosBundleId: 'com.example.blogapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBF6bRrNMhuy1x-Fv1Jmb6pNrGW-gjoXHo',
    appId: '1:606882209979:ios:05ec33c55ed89b6827499e',
    messagingSenderId: '606882209979',
    projectId: 'blogapp-665c6',
    storageBucket: 'blogapp-665c6.appspot.com',
    iosBundleId: 'com.example.blogapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD-cXpcSBd7qt24_k4pGFi_DNzCMUgWIrQ',
    appId: '1:606882209979:web:348dd802f485571927499e',
    messagingSenderId: '606882209979',
    projectId: 'blogapp-665c6',
    authDomain: 'blogapp-665c6.firebaseapp.com',
    storageBucket: 'blogapp-665c6.appspot.com',
    measurementId: 'G-Z4LCXLDT8W',
  );
}