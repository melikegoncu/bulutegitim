import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../pages/mobile_drawer.dart';

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
        body: Container(
          decoration: BoxDecoration(
             color:Color.fromRGBO(227, 227, 227, 0.4)
          ),
            child: Center(child: Text("Anasayfa"))
        ),
        drawer: NavDrawer()
    );
  }
}