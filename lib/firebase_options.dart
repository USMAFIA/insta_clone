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
    apiKey: 'AIzaSyAzUE0RJXSBc9XI_ViS65rl7lVHvLXFl9E',
    appId: '1:1089595039926:web:d68480f385f4b3241dc617',
    messagingSenderId: '1089595039926',
    projectId: 'testing-cli2-e4839',
    authDomain: 'testing-cli2-e4839.firebaseapp.com',
    databaseURL: 'https://testing-cli2-e4839-default-rtdb.firebaseio.com',
    storageBucket: 'testing-cli2-e4839.appspot.com',
    measurementId: 'G-NK1ETE6RSH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCiVpnI0biXmkfiYv8CKrYlHKFvslJnoGs',
    appId: '1:1089595039926:android:55f97b889d7b076d1dc617',
    messagingSenderId: '1089595039926',
    projectId: 'testing-cli2-e4839',
    databaseURL: 'https://testing-cli2-e4839-default-rtdb.firebaseio.com',
    storageBucket: 'testing-cli2-e4839.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDQ_NGOoyLSWam4_25VYxMakvtgyY-f_QY',
    appId: '1:1089595039926:ios:f44d65ce7552a1181dc617',
    messagingSenderId: '1089595039926',
    projectId: 'testing-cli2-e4839',
    databaseURL: 'https://testing-cli2-e4839-default-rtdb.firebaseio.com',
    storageBucket: 'testing-cli2-e4839.appspot.com',
    iosBundleId: 'com.ratedsoltech.instaClone',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDQ_NGOoyLSWam4_25VYxMakvtgyY-f_QY',
    appId: '1:1089595039926:ios:f44d65ce7552a1181dc617',
    messagingSenderId: '1089595039926',
    projectId: 'testing-cli2-e4839',
    databaseURL: 'https://testing-cli2-e4839-default-rtdb.firebaseio.com',
    storageBucket: 'testing-cli2-e4839.appspot.com',
    iosBundleId: 'com.ratedsoltech.instaClone',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAzUE0RJXSBc9XI_ViS65rl7lVHvLXFl9E',
    appId: '1:1089595039926:web:aaf75535e3ddf1981dc617',
    messagingSenderId: '1089595039926',
    projectId: 'testing-cli2-e4839',
    authDomain: 'testing-cli2-e4839.firebaseapp.com',
    databaseURL: 'https://testing-cli2-e4839-default-rtdb.firebaseio.com',
    storageBucket: 'testing-cli2-e4839.appspot.com',
    measurementId: 'G-32JJ40QYW3',
  );

}