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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDDDMUpVuEye0oaZiyWxGMTkGs_9mi5xYI',
    appId: '1:1069680683413:web:e1a5f62958166fbc5d2e9c',
    messagingSenderId: '1069680683413',
    projectId: 'medicationmanager-fd492',
    authDomain: 'medicationmanager-fd492.firebaseapp.com',
    storageBucket: 'medicationmanager-fd492.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBpCL8sKlNLeVXLfJVQd7eCGW3AWSnMHVY',
    appId: '1:1069680683413:android:70d1cb7bbb86501b5d2e9c',
    messagingSenderId: '1069680683413',
    projectId: 'medicationmanager-fd492',
    storageBucket: 'medicationmanager-fd492.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC4wzbFVD0do-gjqGL4vwkhbmtpbqnWmjg',
    appId: '1:1069680683413:ios:f6abaa80ef7688a95d2e9c',
    messagingSenderId: '1069680683413',
    projectId: 'medicationmanager-fd492',
    storageBucket: 'medicationmanager-fd492.appspot.com',
    iosClientId: '1069680683413-qbk53s9qepulpf1assilar0kous2gifi.apps.googleusercontent.com',
    iosBundleId: 'com.alissone.medicationManager',
  );
}
