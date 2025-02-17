// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart';
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
    apiKey: 'AIzaSyCcO5VazYZru2nvND0d5EPQeBbMOcpoRpI',
    appId: '1:488313694613:web:5c87cc98258e483df26e9c',
    messagingSenderId: '488313694613',
    projectId: 'socialmedia-8fb51',
    authDomain: 'socialmedia-8fb51.firebaseapp.com',
    storageBucket: 'socialmedia-8fb51.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAcAkWPTlWrQpbfYg4gyDMWPT3w4djLjH0',
    appId: '1:488313694613:android:076cb9b315747ec3f26e9c',
    messagingSenderId: '488313694613',
    projectId: 'socialmedia-8fb51',
    storageBucket: 'socialmedia-8fb51.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBPU3MS5a8zsJdY3lSIBQmFrWQXZyQUrjA',
    appId: '1:488313694613:ios:13ffa1d76fe15804f26e9c',
    messagingSenderId: '488313694613',
    projectId: 'socialmedia-8fb51',
    storageBucket: 'socialmedia-8fb51.appspot.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBPU3MS5a8zsJdY3lSIBQmFrWQXZyQUrjA',
    appId: '1:488313694613:ios:13ffa1d76fe15804f26e9c',
    messagingSenderId: '488313694613',
    projectId: 'socialmedia-8fb51',
    storageBucket: 'socialmedia-8fb51.appspot.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCcO5VazYZru2nvND0d5EPQeBbMOcpoRpI',
    appId: '1:488313694613:web:fa2803282776002cf26e9c',
    messagingSenderId: '488313694613',
    projectId: 'socialmedia-8fb51',
    authDomain: 'socialmedia-8fb51.firebaseapp.com',
    storageBucket: 'socialmedia-8fb51.appspot.com',
  );

}