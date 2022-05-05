import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeWebScreen extends StatefulWidget {
  const HomeWebScreen({ Key? key }) : super(key: key);

  @override
  State<HomeWebScreen> createState() => _HomeWebScreenState();
}


class _HomeWebScreenState extends State<HomeWebScreen> {
  final _formKey = GlobalKey<FormState>();
    late String  _password, _email, _name;
  final auth = FirebaseAuth.instance;

  String? _value= "Kategoriler";
  @override
  Widget build(BuildContext context) {
  var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 1000),
        child: Container(
          color: Colors.blue,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                Icon(    Icons.cloud_outlined),
                      SizedBox(width: screenSize.width / 60),
                
                Text('Bulut Eğitim'),
                      SizedBox(width: screenSize.width / 20),
                      
        DropdownButton<String>(
          disabledHint:const Text("Choose an item"),
        value: _value,
        items: const <DropdownMenuItem<String>>[
          DropdownMenuItem(
            child:  Text('Kategoriler'),
            value: 'Kategoriler',
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
                    ],
                  ),
                ),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          'Contact Us',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      SizedBox(width: screenSize.width / 20),
                InkWell(
                  onTap: () {},
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.black),
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
                            child: CircleAvatar(
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
                                padding: EdgeInsets.all(8.0),
                                child: TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(  
                  hintText: 'Email'
                ),
                 onChanged: (value) {
                  setState(() {
                    _email = value.trim();
                  });
                },),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(hintText: 'Şifre', prefixIcon: Icon(Icons.lock)),
                  
                  onChanged: (value) {
                    setState(() {
                      _password = value.trim();
                    });
                  },),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: 
              FloatingActionButton(
                heroTag: "login",
                backgroundColor: Colors.amber,
                child: const Text('Giriş Yap',
                textAlign: TextAlign.center),
                onPressed: (){
                    auth.signInWithEmailAndPassword(email: _email, password: _password).then((_){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomeWebScreen()));
                    });
              }),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                });},
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // AppBar(leading: const Icon(    Icons.cloud_outlined,  ),
      // title: const Text("Bulut Eğitim"),
      // actions: <Widget>[
      //   DropdownButton<String>(
      //     disabledHint:const Text("Choose an item"),
      //   value: _value,
      //   items: const <DropdownMenuItem<String>>[
      //      DropdownMenuItem(
      //       child:  Text('Amazon Web Services'),
      //       value: 'AWS',
      //     ),
      //      DropdownMenuItem(
      //       child:  Text('Microsoft Azure'),
      //       value: 'MicrosoftAzure',
      //     ), DropdownMenuItem(
      //       child:  Text('Google Cloud Platform'),
      //       value: 'GoogleCloudPlatform',
      //     ), DropdownMenuItem(
      //       child: Text('Alibaba Cloud'),
      //       value: 'AlibabaCloud',
      //     ), DropdownMenuItem(
      //       child: Text('Big Data'),
      //       value: 'BigData',
      //     ), DropdownMenuItem(
      //       child: Text('Business Management'),
      //       value: 'BusinessManagement',
      //     ), DropdownMenuItem(
      //       child: Text('Cloud Computing Fundamentals'),
      //       value: 'CloudComputingFundamentals',
      //     ),
      //   ], 
      //   onChanged: (String? value) {
      //     setState(() => _value = value);
      //   },
      // ),
      // ],
      // ),
    );
  }
}