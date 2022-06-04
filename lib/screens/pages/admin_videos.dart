import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


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
      body: StreamBuilder(stream: FirebaseFirestore.instance.collection('Users/*/course').snapshots(), 
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator(),);
        }
        return ListView(children: snapshot.data!.docs.map((DocumentSnapshot document){
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
          return Card(
            child: Column(
              children: [
                Icon(Icons.video_file),
                ListTile(
                  leading:  Text("Onay Durumu: " + document['approval']),
                  title: Text("Link: " + document['courseUrl']),
                ),
              ],
            ),
          );
        }).toList(),);
        },),
        drawer: AdminDrawer(),
    );
  }
}