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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDhG2MJR211HKrmRz74sQyx7dqkxxYpv2A',
    appId: '1:937792262665:android:33da03933a4f73fecdded8',
    messagingSenderId: '937792262665',
    projectId: 'fir-app-10500',
    storageBucket: 'fir-app-10500.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDTjAW4Er2ZbjF7wjy2H8DBHzXaXatclfw',
    appId: '1:937792262665:ios:d2ac472d57e20c97cdded8',
    messagingSenderId: '937792262665',
    projectId: 'fir-app-10500',
    storageBucket: 'fir-app-10500.appspot.com',
    androidClientId: '937792262665-1opv61iksbv8sv0stc5cejllagmdj3od.apps.googleusercontent.com',
    iosClientId: '937792262665-ptbnumcha53in5jvitruqc53g9sv8lc7.apps.googleusercontent.com',
    iosBundleId: 'com.noa99kee.flutterBasicApp',
  );
}
