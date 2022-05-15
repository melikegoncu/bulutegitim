import 'package:bulutegitim/net/firebase.dart';
import 'package:bulutegitim/screens/auth/sign_in_mobile.dart';
import 'package:bulutegitim/screens/home/home_mobile.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_switch/flutter_switch.dart';
class SignupScreen extends StatefulWidget {
  const SignupScreen({ Key? key }) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
    final _formKey = GlobalKey<FormState>();
    String role="Öğrenci";
    Map<String, String> roles = {'Öğrenci': "student", 'Eğitmen': "instructor"};
    bool statusRole= true;
    final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final auth = FirebaseAuth.instance;

   switch_role () {
   setState(() {
     if(role=="Öğrenci") {
      role="Eğitmen"; statusRole=false;
      }
     else{
      role="Öğrenci";statusRole=true;
      } 
   });
 } 
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
                  validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Lütfen bir isim giriniz.';
              }
              if (value.length <6) {
                return 'En az 6 karakter giriniz.';
              }
              return null;
            },
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
                  validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Lütfen bir mail giriniz.';
              }
              else if (!value.contains('@') && !value.contains('.com')) {
                return 'Geçersiz bir mail adresi girdiniz.';
              }
              return null;
            },
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
                  validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Lütfen bir şifre belirleyiniz.';
              }
              if (value.length <6) {
                return 'En az 6 karakterli bir şifre giriniz.';
              }
              return null;
            },
                  obscureText: true,
                  controller: _passwordController,
                  decoration: const InputDecoration(hintText: 'Şifre', prefixIcon: Icon(Icons.lock)),
                ),
                
              ),
              Row(
                children: [
                  FlutterSwitch(
			activeText: "Öğrenci",
			inactiveText: "Eğitmen",
			value: statusRole,
			valueFontSize: 16.0,
			width: 100,
			height: 50,
			borderRadius: 30.0,
			showOnOff: true,
			onToggle: (val) {
				switch_role();
			},
			),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:[
                FloatingActionButton( 
                  heroTag: "signup",
                  backgroundColor: Colors.amber,
                  child: const Text('Kaydol'),
                  onPressed: ()async{
                    if(_formKey.currentState!.validate()){
                      try {
                    await auth.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
                    User updateUser = auth.currentUser!;
                    updateUser.updateDisplayName(_usernameController.text);
                    userSetup(_usernameController.text,roles[role]);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Home()));
                    } on FirebaseAuthException catch (error) {
                    Fluttertoast.showToast(msg: error.message!,gravity: ToastGravity.TOP,);
                    }
                    }
                  },
                )
              ])
            ],),
        ),
      ),
    );
  }
}