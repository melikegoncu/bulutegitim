import 'package:bulutegitim/net/firebase.dart';
import 'package:bulutegitim/screens/auth/sign_in_mobile.dart';
import 'package:bulutegitim/screens/home/home_mobile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class SignupScreen extends StatefulWidget {
  const SignupScreen({ Key? key }) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold( resizeToAvoidBottomInset: false, 
      appBar: AppBar(title: const Text('Bulut Eğitim'),
      actions: [
        IconButton(onPressed: () { Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const SignInScreen()));
              }, icon: const Icon(Icons.exit_to_app))
      ],),
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
                  controller: _usernameController,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(  
                    prefixIcon: Icon(Icons.person),
        
                    hintText: 'Tam Ad'
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(  
                     prefixIcon: Icon(Icons.mail),
                    hintText: 'Email'
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: const InputDecoration(hintText: 'Şifre', prefixIcon: Icon(Icons.lock)),
                ),
                
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:[
                FloatingActionButton( 
                  heroTag: "signup",
                  backgroundColor: Colors.amber,
                  child: const Text('Kaydol'),
                  onPressed: ()async{
                    await auth.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
                    User updateUser = auth.currentUser!;
                    updateUser.updateDisplayName(_usernameController.text);
                    userSetup(_usernameController.text);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Home()));
                  },
                )
              ])
            ],),
        ),
      ),
    );
  }
}