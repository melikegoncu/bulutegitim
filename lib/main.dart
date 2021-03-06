import 'package:bulutegitim/screens/auth/sign_in_mobile.dart';
import 'package:bulutegitim/screens/home/home_web.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    if (kIsWeb) {  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "api_key_here",
          appId: "1:192475888110:web:507de23fc29cf2098bf6ff",
          messagingSenderId: "192475888110",
          projectId: "bulutegitim-2f12a",
          storageBucket: "bulutegitim-2f12a.appspot.com"));
  
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: HomeWebScreen()));
}

 else {
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "api_key_here",
          appId: "1:192475888110:android:3bce6e295c41272f8bf6ff",
          messagingSenderId: "192475888110",
          projectId: "bulutegitim-2f12a",
          storageBucket: "bulutegitim-2f12a.appspot.com"));
  
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: SignInScreen()));
}
}
