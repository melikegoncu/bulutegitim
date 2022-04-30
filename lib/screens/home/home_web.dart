import 'package:flutter/material.dart';

class HomeWebScreen extends StatefulWidget {
  const HomeWebScreen({ Key? key }) : super(key: key);

  @override
  State<HomeWebScreen> createState() => _HomeWebScreenState();
}

class _HomeWebScreenState extends State<HomeWebScreen> {
  String? _value= "AWS";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const Icon(    Icons.cloud_outlined,  ),
      title: const Text("Bulut Eğitim"),
      actions: <Widget>[
        DropdownButton<String>(
          disabledHint:const Text("Choose an item"),
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
    );
  }
}