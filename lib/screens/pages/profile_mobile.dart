import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'mobile_drawer.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text("Bulut Eğitim")
        ),
        body: Container(
          decoration: BoxDecoration(
             color:Color.fromRGBO(227, 227, 227, 0.4)
          ),
            child: Center(child: Text("Profil"))
        ),
        drawer: NavDrawer()
    );
  }
}