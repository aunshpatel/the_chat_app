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
    apiKey: 'AIzaSyDQgKKpV3EASAJggKG3ZTuH8NWv5817bpQ',
    appId: '1:714651199338:web:5086a305531f11a886e713',
    messagingSenderId: '714651199338',
    projectId: 'the-chat-app-51b',
    authDomain: 'the-chat-app-51b.firebaseapp.com',
    databaseURL: 'https://the-chat-app-51b-default-rtdb.firebaseio.com',
    storageBucket: 'the-chat-app-51b.appspot.com',
    measurementId: 'G-WJH9VCPK9E',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCAtLG0vHm1DDIh3Cy6WiqQ1nPGTE081QI',
    appId: '1:714651199338:android:4ba2620c8dbae5e786e713',
    messagingSenderId: '714651199338',
    projectId: 'the-chat-app-51b',
    databaseURL: 'https://the-chat-app-51b-default-rtdb.firebaseio.com',
    storageBucket: 'the-chat-app-51b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDDPud50VZ-olFPpIuvL_IxPNca8nHwgls',
    appId: '1:714651199338:ios:843308ba44a46f1986e713',
    messagingSenderId: '714651199338',
    projectId: 'the-chat-app-51b',
    databaseURL: 'https://the-chat-app-51b-default-rtdb.firebaseio.com',
    storageBucket: 'the-chat-app-51b.appspot.com',
    iosClientId: '714651199338-5a28b01unn7biklgkcs502da27mmdurr.apps.googleusercontent.com',
    iosBundleId: 'com.aunsh.theChatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDDPud50VZ-olFPpIuvL_IxPNca8nHwgls',
    appId: '1:714651199338:ios:5743ee83f0acc2c386e713',
    messagingSenderId: '714651199338',
    projectId: 'the-chat-app-51b',
    databaseURL: 'https://the-chat-app-51b-default-rtdb.firebaseio.com',
    storageBucket: 'the-chat-app-51b.appspot.com',
    iosClientId: '714651199338-ogs7lrk4m67n0a0luu1t59thk2ssblnr.apps.googleusercontent.com',
    iosBundleId: 'com.example.theChatApp',
  );
}
