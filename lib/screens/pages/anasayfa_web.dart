import 'package:bulutegitim/screens/pages/play_course_web.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Anasayfa_web extends StatefulWidget {
  const Anasayfa_web({Key? key}) : super(key: key);

  @override
  State<Anasayfa_web> createState() => _Anasayfa_webState();
}

class _Anasayfa_webState extends State<Anasayfa_web> {
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
////////////snapshot.data.toString()
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
                    width: 500,
                    height: 120,
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
                                            builder: (context) => Player_web(snapshot.data.toString()),
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
      });
  }
}
