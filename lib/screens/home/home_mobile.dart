import 'package:bulutegitim/screens/pages/play_course_mobile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import '../pages/mobile_drawer.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? _value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Bulut Eğitim"),
          
          
        ),
      body: StreamBuilder(stream: FirebaseFirestore.instance.collection("Video")
.where("approval",isEqualTo: "approved").snapshots(), 
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator(),);
        }
        return ListView(children: snapshot.data!.docs.map((DocumentSnapshot document){
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
          return Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ListTile(
                  tileColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                  title: Text("Video İsmi: " + document['videoName']),
                  leading:  Image.network(
                              'https://thumbs.dreamstime.com/z/acrylic-illustration-blue-cloud-holding-book-enjoys-reading-book-blue-cloud-holding-book-enjoys-reading-161466410.jpg',
                              fit: BoxFit.fill,
                            ),
                  subtitle:  Text("Eğitimci: " + document['instructorName'],),
                  trailing:  IconButton(
              icon: const Icon(Icons.play_circle_filled_rounded),
              onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                              builder: (context) => Player_mobile(document['url']),
                              ),
                            );
              },
            ),
                  // trailing:  FloatingActionButton.extended(
                  //   heroTag: "mobileplay",
                  //   backgroundColor: Colors.amber,
                  //   label: Text('İzle',
                  //   textAlign: TextAlign.center),
                  //   onPressed: ()async{
                  //     try {
                  //       Navigator.push(
                  //                         context,
                  //                         MaterialPageRoute(
                  //                           builder: (context) => Player_mobile(document['url']),
                  //                         ),
                  //                         );
                  //     } catch (e) {
                        
                  //     }
                  // }),
                  isThreeLine: true,
                ),
              ],
            ),
          );
        }).toList(),);
        },),
        drawer: NavDrawer()
    );
  }
}