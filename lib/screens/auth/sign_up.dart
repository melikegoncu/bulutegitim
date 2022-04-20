import 'package:bulutegitim/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class SignupScreen extends StatefulWidget {
  const SignupScreen({ Key? key }) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
    late String _email, _password, _name;
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
                
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(  
                  prefixIcon: Icon(Icons.person),

                  hintText: 'Tam Ad'
                ),
                 onChanged: (value) {
                  setState(() {
                    _name = value.trim();
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(  
                   prefixIcon: Icon(Icons.mail),
                  hintText: 'Email'
                ),
                 onChanged: (value) {
                  setState(() {
                    _email = value.trim();
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                obscureText: true,
                decoration: const InputDecoration(hintText: 'Şifre', prefixIcon: Icon(Icons.lock)),
                
                onChanged: (value) {
                  setState(() {
                    _password = value.trim();
                  });
                },
              ),
              
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:[
              FloatingActionButton( 
                heroTag: "signup",
                backgroundColor: Colors.amber,
                child: const Text('Kaydol'),
                onPressed: (){
                  auth.createUserWithEmailAndPassword(email: _email, password: _password).then((_){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Home()));
                  });
                },
              )
            ])
          ],),
      ),
    );
  }
}