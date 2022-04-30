import 'package:bulutegitim/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      appBar: AppBar(title: const Text("Bulut Eğitim"),
      actions: <Widget>[
    IconButton(
      icon: const Icon(
        Icons.logout,
        color: Colors.white,
      ),
      onPressed: () {
        auth.signOut();
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const Wrapper()));
        // do something
      },
    )
  ],
      ),
      body: Column(),
    );/*Container(
    decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/selfiedoodle.png"), fit: BoxFit.cover)),
    child: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(title: const Text("HomePage"),// Your app bar
      backgroundColor: const Color(0xff6ae792),
      ),
      body: Column(
        children: [
          Padding(padding: const EdgeInsets.all(8.0),
        child:FloatingActionButton(
          child: const Text("SignOut"),
          onPressed: () {auth.signOut();
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const Wrapper()));} ,
          ),
        )
        ],
      ),
    ),
  );*/
    
    /*Scaffold(
      appBar: AppBar(title: const Text("HomePage")),
      body: Column(children: [
        Padding(padding: const EdgeInsets.all(8.0),
        child:FloatingActionButton(
          child: const Text("SignOut"),
          onPressed: () {auth.signOut();
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const Wrapper()));} ,
          ),
        )
      ]),
    );*/
  }
}