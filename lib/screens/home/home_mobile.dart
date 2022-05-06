import 'package:bulutegitim/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../pages/drawer.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final auth = FirebaseAuth.instance;
  String? _value;

  @override
  Widget build(BuildContext context) {
  var screenSize = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Bulut Eğitim"),
          actions: [
            SizedBox(
              width: 100,
              child: DropdownButton<String>(//scroll ekle
                isExpanded: true,
                      hint:const Icon(Icons.category)/* Text("Choose an item") */,
                    value: _value,
                    items: const <DropdownMenuItem<String>>[
                      DropdownMenuItem(
              child:  Text('Categories'),
              value: 'Categories',
                      ),
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
            ),
          ],
        ),
        body: Center(
            child: Center(child: Text("Anasayfa"))
        ),
        drawer: NavDrawer()
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