import 'package:bulutegitim/net/firebase.dart';
import 'package:flutter/material.dart';

class Communicate extends StatefulWidget {
  const Communicate({Key? key}) : super(key: key);

  @override
  State<Communicate> createState() => _CommunicateState();
}

class _CommunicateState extends State<Communicate> {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _mailController = TextEditingController();
    final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
  var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 1000),
        child: Container(
          color: Colors.blue,
          child: IconButton(onPressed: () {
            Navigator.pop(context);
          },
          icon:  const Icon(Icons.arrow_back))
        ),
      ),
      body: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Lütfen mailinizi giriniz.';
              }
              else if (!value.contains('@') && !value.contains('.com')) {
                return 'Geçersiz bir mail adresi girdiniz.';
              }
              return null;
            },
                  controller: _mailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(  
                    prefixIcon: Icon(Icons.mail),
        
                    hintText: 'Mail'
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Lütfen bir mesaj giriniz.';
              }
              return null;
            },
                  controller: _messageController,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(  
                     prefixIcon: Icon(Icons.note_add),
                    hintText: 'Message'
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:[
                FloatingActionButton( 
                  heroTag: "Submit",
                  backgroundColor: Colors.amber,
                  child: const Text('Gönder'),
                  onPressed: ()async{
                    commentSetup(_mailController.text, _messageController.text);
                    _mailController.clear();
                    _messageController.clear();
                  },
                )
              ])
            ],),
        ),
    );
  }
}