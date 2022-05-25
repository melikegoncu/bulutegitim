import 'package:bulutegitim/screens/pages/play_course_mobile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../pages/mobile_drawer.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final auth = FirebaseAuth.instance;
  String? _value;
    Future<ListResult> getFirebaseVideo() async {
    final ref = await FirebaseStorage.instance.ref('courses').listAll();

    ref.items.forEach((refe) {
      print('Eleman: $refe');
    });
    return ref;
  }
    
  Future<String> downloadURL(String videoNames) async {
    String downloadURL = await FirebaseStorage.instance.ref('courses/$videoNames').getDownloadURL();
    return downloadURL;
  }

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
        body: FutureBuilder(
      future: getFirebaseVideo(),
      builder: (BuildContext context, AsyncSnapshot<ListResult> snapshot){
        if(snapshot.connectionState == ConnectionState.done &&
          snapshot.hasData){
            return Scrollbar(
              thickness: 10,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount:snapshot.data!.items.length,
                itemBuilder: (BuildContext context, int index){
                  return Container(
                    width: 100,
                    height: 50,
                    child: Card(
                      margin: EdgeInsets.all(15),
                            elevation: 10,
                            shape: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              borderSide: BorderSide.none,
                            ),
                      child: Column(
                        children: [
                          FutureBuilder(
                        future: downloadURL(snapshot.data!.items[index].name),
                        builder: (BuildContext context, AsyncSnapshot<String> snapshot){
                          if(snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData){
                              return GestureDetector(
                                onTap: () {
                                          Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Player_mobile(snapshot.data.toString()),
                                          ),
                                          );
                                },
                            child:Image.network(
                              'https://thumbs.dreamstime.com/z/acrylic-illustration-blue-cloud-holding-book-enjoys-reading-book-blue-cloud-holding-book-enjoys-reading-161466410.jpg',
                              fit: BoxFit.fill,
                            ),);
                            }
                          return Container();
                        }),
                          Text(snapshot.data!.items[index].name),
                        ],
                      ),
                    ),
                  );
                }
                ),
            );
          }
        return Container();
      }),
        drawer: NavDrawer()
    );
  }
}