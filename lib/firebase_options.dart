import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
      apiKey: "AIzaSyAXz3X_PjgZtxaQyorzsc8HUhtLq_m_HxY",
      authDomain: "union-shop12345.firebaseapp.com",
      projectId: "union-shop12345",
      storageBucket: "union-shop12345.firebasestorage.app",
      messagingSenderId: "800803385644",
      appId: "1:800803385644:web:870b98a9c2ea727e837c89");
}
