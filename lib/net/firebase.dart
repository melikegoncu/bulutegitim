import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final CollectionReference _mainCollection = FirebaseFirestore.instance.collection('Users');
final CollectionReference _commentCollection = FirebaseFirestore.instance.collection('Comment');
final CollectionReference _videoCollection = FirebaseFirestore.instance.collection('Video');
final FirebaseAuth auth = FirebaseAuth.instance;

  String uid = auth.currentUser!.uid.toString();
  String displayName = auth.currentUser!.displayName.toString();
    DocumentReference documentReferencer =
      _mainCollection.doc(uid);
          DocumentReference commentReferencer =
      _commentCollection.doc();
          DocumentReference videoReferencer =
      _videoCollection.doc();

Future<void> userSetup(String displayName, [roles = "student"]) async {
    Map<String, dynamic> data = <String, dynamic>{
    'displayName': displayName,
    'uid':uid,
    'roles': roles
  };
    await documentReferencer
      .set(data)
      .whenComplete(() => print("User item added to the database"))
      .catchError((e) => print(e));
  return;
}
Future<void> videoSetup(String url,String videoName, String instructorName, String description, String categories, [approval = "unapproved"]) async {
    Map<String, dynamic> data = <String, dynamic>{
    'url': url,
    'videoName':videoName,
    'instructorName': instructorName,
    'uid':uid,
    'description':description,
    'categories':categories,
    'approval':approval
  };
    await videoReferencer
      .set(data)
      .whenComplete(() => print("Videos item added to the database"))
      .catchError((e) => print(e));
  return;
}

Future<void> commentSetup(String mail,String comment) async {
    Map<String, dynamic> data = <String, dynamic>{
    'mail': mail,
    'comment':comment
  };
    await commentReferencer
      .set(data)
      .whenComplete(() => print("Comments item added to the database"))
      .catchError((e) => print(e));
  return;
}


Future<void> roleUpdate([String? displayName,String? roles]) async {
    Map<String, dynamic> data = <String, dynamic>{
    'displayName': displayName,
    'roles': roles
  };
  await documentReferencer
      .update(data)
      .whenComplete(() => print("Roles item updated in the database"))
      .catchError((e) => print(e));
  return;
}

Future<void> deleteItem({
  required String docId,
}) async {
  await documentReferencer
      .delete()
      .whenComplete(() => print('User item deleted from the database'))
      .catchError((e) => print(e));
}
// Stream<QuerySnapshot> readItems() {
//   CollectionReference notesItemCollection =
//       _mainCollection.doc(uid).collection('Users');

//   return notesItemCollection.snapshots();
// }

// Future<Stream<QuerySnapshot>> getUserData() async{
//     var firebaseUser = auth.currentUser!;
//     return await FirebaseFirestore.instance.collection("Users").where("uid"==firebaseUser.uid).snapshots();
//   }

getUserData() async {
  final firebaseUser = await FirebaseAuth.instance.currentUser;
  if (firebaseUser != null)
    await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser.uid)
        .get()
        .then((ds) {
      displayName = ds.data()?['displayName'];
      print(displayName);
    }).catchError((e) {
      print(e);
    });
}
Future<Map<String, dynamic>> readUser() async{
     var firebaseUser = auth.currentUser!;

  final docUser = FirebaseFirestore.instance.collection("Users").doc(firebaseUser.uid);
  final snapshot = await docUser.get();

    return snapshot.data()!;
}