import 'package:bulutegitim/screens/pages/play_course_web.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Anasayfa_web extends StatefulWidget {
  const Anasayfa_web({Key? key}) : super(key: key);

  @override
  State<Anasayfa_web> createState() => _Anasayfa_webState();
}

class _Anasayfa_webState extends State<Anasayfa_web> {

////////////snapshot.data.toString()
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       floatingActionButton: null,
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
                  trailing:  FloatingActionButton.extended(
                    heroTag: "play",
                    backgroundColor: Colors.amber,
                    label: Text('İzle',
                    textAlign: TextAlign.center),
                    onPressed: ()async{
                      try {
                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Player_web(document['url']),
                                          ),
                                          );
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
    );
  }

}
