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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getFirebaseVideo(),
      builder: (BuildContext context, AsyncSnapshot<ListResult> snapshot){
        if(snapshot.connectionState == ConnectionState.done &&
          snapshot.hasData){
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount:snapshot.data!.items.length,
              itemBuilder: (BuildContext context, int index){
                return Text(snapshot.data!.items[index].name);
              }
              );
          }
        return Container();
      });
  }
}
