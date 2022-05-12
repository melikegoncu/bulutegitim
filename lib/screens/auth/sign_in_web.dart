import 'package:bulutegitim/screens/auth/sign_up_mobile.dart';
import 'package:bulutegitim/screens/home/home_web.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class SignInScreenWeb extends StatefulWidget {
  const SignInScreenWeb({ Key? key }) : super(key: key);

  @override
  State<SignInScreenWeb> createState() => _SignInScreenWebState();
}

class _SignInScreenWebState extends State<SignInScreenWeb> {
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
        image: AssetImage('assets/weblogin.png'),
        fit: BoxFit.fill),//boyutlandırmaya bakılacak
  ),
        child: Expanded(
          child: Column( 
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                child: TextFormField(
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
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomeWebScreen()));
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
      ),
    );
  }
}