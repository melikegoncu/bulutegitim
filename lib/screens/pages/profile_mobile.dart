import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../net/firebase.dart';
import 'mobile_drawer.dart';

class ProfileMobile extends StatefulWidget {
  const ProfileMobile({ Key? key }) : super(key: key);

  @override
  State<ProfileMobile> createState() => _ProfileMobileState();
}

class _ProfileMobileState extends State<ProfileMobile> {
  final auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text("Bulut Eğitim")
        ),
        body: Container(
                      color: Colors.white,
                      child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(padding: const EdgeInsets.all(8.0),
                              child:TextFormField(
                                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen isim giriniz.';
                    //return 'Lütfen isim giriniz.' + snapshot.data.toString();
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
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: 
                  FloatingActionButton.extended(
                    heroTag: "mobileupdate",
                    backgroundColor: Colors.amber,
                    label: Text('Güncelle',
                    textAlign: TextAlign.center),
                    onPressed: ()async{
                      if(_formKey.currentState!.validate()){
                      try {
                      // await auth.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
                      User updateUser = auth.currentUser!;
                      updateUser.updateDisplayName(_usernameController.text);
                      roleUpdate(_usernameController.text);
                      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const WebEnterancePage()));
                      } on FirebaseAuthException catch (error) {
                      //Fluttertoast.showToast(msg: error.message!,gravity: ToastGravity.TOP,);
                      }}
                  }),
                              ),
                            ],
                          ),
                        ),
                    ),
        drawer: NavDrawer()
    );
  }
}