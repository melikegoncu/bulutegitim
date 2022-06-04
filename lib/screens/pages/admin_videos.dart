import 'package:bulutegitim/screens/pages/play_course_web.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import '../../net/firebase.dart';
import 'admin_drawer.dart';

class AdminVideos extends StatefulWidget {
  const AdminVideos({Key? key}) : super(key: key);

  @override
  State<AdminVideos> createState() => _AdminVideosState();
}

class _AdminVideosState extends State<AdminVideos> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 1000),
        child: Container(
          color: Colors.blue,
          child: Padding(
            padding: const EdgeInsets.all(20), 
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(onPressed: () {AdminDrawer();}, icon: Icon(Icons.exit_to_app)),
                        SizedBox(width: screenSize.width / 60),
                      const Icon(    Icons.cloud_outlined),
                        SizedBox(width: screenSize.width / 60),
                      const Text('Bulut Eğitim'),
                        SizedBox(width: screenSize.width / 20),
        
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: null,
      body: StreamBuilder(stream: FirebaseFirestore.instance.collection("Video")
.where("approval",isEqualTo: "unapproved").snapshots(), 
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
                  leading:  IconButton(
              icon: Icon(Icons.video_file),
              onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Player_web(document['url'])));
              },
            ),
                  subtitle:  Text("Eğitimci: " + document['instructorName'],),
                  trailing:  FloatingActionButton.extended(
                    heroTag: "approve",
                    backgroundColor: Colors.amber,
                    label: Text('Onay',
                    textAlign: TextAlign.center),
                    onPressed: ()async{
                      try {
                        approve(document.id);
                      } catch (e) {
                        
                      }
                  }),
                  isThreeLine: true,
                ),
              ],
            ),
          );
        }).toList(),);
        },),
        drawer: AdminDrawer(),
    );
  }
  
  void approve(String id) {
    videoApprove("approved",id);
  }
}