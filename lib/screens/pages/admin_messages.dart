
import 'package:bulutegitim/screens/pages/admin_drawer.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListComment extends StatefulWidget {
  const ListComment({Key? key}) : super(key: key);

  @override
  State<ListComment> createState() => _ListCommentState();
}

class _ListCommentState extends State<ListComment> {

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return  Scaffold(
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
      body: StreamBuilder(stream: FirebaseFirestore.instance.collection('Comment').snapshots(), 
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator(),);
        }
        return ListView(children: snapshot.data!.docs.map((DocumentSnapshot document){
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
          return Card(
            child: Column(
              children: [
                Icon(Icons.person),
                ListTile(
                  leading:  Text("Mail Adresi: " + document['mail']),
                  title: Text("Yorum: " + document['comment']),
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