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
  final _formKey = GlobalKey<FormState>();
    final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(  
                    prefixIcon: Icon(Icons.mail),
                    hintText: 'Email'
                  ),),),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: const InputDecoration(prefixIcon: Icon(Icons.lock),
                    hintText: 'Şifre'),
                  ),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:[
                FloatingActionButton(
                  heroTag: "login",
                  backgroundColor: Colors.amber,
                  child: const Text('Giriş Yap',
                  textAlign: TextAlign.center),
                  onPressed: (){
                      auth.signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Home()));
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