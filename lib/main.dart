import 'package:bulutegitim/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyA5DzQqLkkwt_NFEGN19Mje3k7SLdeZBR8",
          appId: "1:192475888110:web:507de23fc29cf2098bf6ff",
          messagingSenderId: "192475888110",
          projectId: "bulutegitim-2f12a"));
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: Wrapper()));
}
