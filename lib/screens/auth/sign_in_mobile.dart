import 'package:bulutegitim/screens/auth/sign_up_mobile.dart';
import 'package:bulutegitim/screens/home/home_mobile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late String _email, _password;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold( resizeToAvoidBottomInset: false, 
      appBar: AppBar(title: const Text('Bulut Eğitim'),),
      body: Container(
      width: double.infinity,
      decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/girissayfa.jpeg'),
        fit: BoxFit.fill),//boyutlandırmaya bakılacak
  ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(  
                  hintText: 'Email'
                ),
                 onChanged: (value) {
                  setState(() {
                    _email = value.trim();
                  });
                },),),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                obscureText: true,
                decoration: const InputDecoration(hintText: 'Şifre'),
                onChanged: (value) {
                  setState(() {
                    _password = value.trim();
                  });
                },),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:[
              FloatingActionButton(
                heroTag: "login",
                backgroundColor: Colors.amber,
                child: const Text('Giriş Yap',
                textAlign: TextAlign.center),
                onPressed: (){
                    auth.signInWithEmailAndPassword(email: _email, password: _password).then((_){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Home()));
                    });
              }),
              FloatingActionButton( 
                heroTag: "signup",
                backgroundColor: Colors.amber,
                child: const Text('Kaydol'),
                onPressed: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const SignupScreen()));
                },
              )
            ])
          ],),
      ),
    );
  }
}