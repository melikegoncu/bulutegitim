import 'package:bulutegitim/screens/auth/sign_in.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(  
      title: 'Login App',
      theme: ThemeData(  
        primarySwatch: Colors.blue
      ),
      home: const SignInScreen(),
    );
  }
}