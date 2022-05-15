import 'package:bulutegitim/screens/auth/web_entrance.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../net/firebase.dart';

class HomeWebScreen extends StatefulWidget {
  const HomeWebScreen({ Key? key }) : super(key: key);

  @override
  State<HomeWebScreen> createState() => _HomeWebScreenState();
}


class _HomeWebScreenState extends State<HomeWebScreen> {
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
  String? _value;
  @override
  Widget build(BuildContext context) {
  var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 1000),
        child: Container(
          color: Colors.blue,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                const Icon(    Icons.cloud_outlined,color: Colors.white),
                      SizedBox(width: screenSize.width / 60),
                
                const Text('Bulut Eğitim',
                style: TextStyle(color: Colors.white)),
                      SizedBox(width: screenSize.width / 20),
                      
        DropdownButton<String>(
          iconEnabledColor: Colors.white,
          hint:const Text("Kategoriler", style: TextStyle(color: Colors.white)),
        value: _value,
        items: const <DropdownMenuItem<String>>[
           DropdownMenuItem(
            child:  Text('Amazon Web Services'),
            value: 'AWS',
          ),
           DropdownMenuItem(
            child:  Text('Microsoft Azure'),
            value: 'MicrosoftAzure',
          ), DropdownMenuItem(
            child:  Text('Google Cloud Platform'),
            value: 'GoogleCloudPlatform',
          ), DropdownMenuItem(
            child: Text('Alibaba Cloud'),
            value: 'AlibabaCloud',
          ), DropdownMenuItem(
            child: Text('Big Data'),
            value: 'BigData',
          ), DropdownMenuItem(
            child: Text('Business Management'),
            value: 'BusinessManagement',
          ), DropdownMenuItem(
            child: Text('Cloud Computing Fundamentals'),
            value: 'CloudComputingFundamentals',
          ),
        ], 
        onChanged: (String? value) {
          setState(() => _value = value);
        },
      ),
                    ],
                  ),
                ),
                      InkWell(
                        onTap: () {},
                        child: const Text(
                          "İletişim",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(width: screenSize.width / 20),
                InkWell(
                  onTap: () {showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Stack(
                      clipBehavior: Clip.antiAlias,
                      children: <Widget>[
                        Positioned(
                          right: -40.0,
                          top: -40.0,
                          child: InkResponse(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const CircleAvatar(
                              child: Icon(Icons.close),
                              backgroundColor: Colors.red,
                            ),
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(padding: const EdgeInsets.all(8.0),
                              child:TextFormField(
                                validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Lütfen isim giriniz.';
              }
              return null;
            },
                                controller: _usernameController,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(  
                    prefixIcon: Icon(Icons.person),
        
                    hintText: 'Tam Ad'
                  ),
                ),),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Lütfen mail adresinizi giriniz.';
              }
              else if (!value.contains('@') && !value.contains('.com')) {
                return 'Geçersiz bir mail adresi girdiniz.';
              }
              return null;
            },
                                  controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(  
                  hintText: 'Email',prefixIcon: Icon(Icons.mail)
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
              return null;
            },
                                  controller: _passwordController,
                  obscureText: true,
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
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: 
              FloatingActionButton(
                heroTag: "login",
                backgroundColor: Colors.amber,
                child: const Text('Kaydol',
                textAlign: TextAlign.center),
                onPressed: ()async{
                  if(_formKey.currentState!.validate()){
                  try {
                    await auth.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
                    User updateUser = auth.currentUser!;
                    updateUser.updateDisplayName(_usernameController.text);
                    userSetup(_usernameController.text,roles[role]);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const WebEnterancePage()));
                    } on FirebaseAuthException catch (error) {
                    Fluttertoast.showToast(msg: error.message!,gravity: ToastGravity.TOP,);
                    }}
              }),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
                );},
                  child: const Text(
                    'Kaydol',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  width: screenSize.width / 50,
                ),
                InkWell(
                  onTap: () {showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Stack(
                      clipBehavior: Clip.antiAlias,
                      children: <Widget>[
                        Positioned(
                          right: -40.0,
                          top: -40.0,
                          child: InkResponse(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const CircleAvatar(
                              child: Icon(Icons.close),
                              backgroundColor: Colors.red,
                            ),
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Lütfen mail adresinizi giriniz.';
              }
              return null;
            },
                                  controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(  
                  hintText: 'Email',prefixIcon: Icon(Icons.mail)
                ),
                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Lütfen şifrenizi giriniz.';
              }
              return null;
            },
                                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(hintText: 'Şifre', prefixIcon: Icon(Icons.lock)),
                  ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: 
              FloatingActionButton(
                heroTag: "login",
                backgroundColor: Colors.amber,
                child: const Text('Giriş Yap',
                textAlign: TextAlign.center),
                onPressed: ()async{
                  if(_formKey.currentState!.validate()){
                    await auth.signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const WebEnterancePage()));
                  }
              }),
                              )
                            ],
                          ),
                        ),
                        
                      ],
                    ),
                  );
                }
                );
                },
                  child: const Text(
                    'Giriş Yap',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}