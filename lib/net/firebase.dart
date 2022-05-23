import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final CollectionReference _mainCollection = FirebaseFirestore.instance.collection('Users');
final FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser!.uid.toString();
    DocumentReference documentReferencer =
      _mainCollection.doc(uid);

Future<void> userSetup(String displayName, [roles = "student"]) async {
    Map<String, dynamic> data = <String, dynamic>{
    'displayName': displayName,
    'uid':uid,
    'roles': roles
  };
    await documentReferencer
      .set(data)
      .whenComplete(() => print("Notes item added to the database"))
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
      .whenComplete(() => print("Note item updated in the database"))
      .catchError((e) => print(e));
  return;
}

Future<void> deleteItem({
  required String docId,
}) async {
  await documentReferencer
      .delete()
      .whenComplete(() => print('Note item deleted from the database'))
      .catchError((e) => print(e));
}
Stream<QuerySnapshot> readItems() {
  CollectionReference notesItemCollection =
      _mainCollection.doc(uid).collection('Users');

  return notesItemCollection.snapshots();
}

Future<Stream<QuerySnapshot>> getUserData() async{
    var firebaseUser = auth.currentUser!;
    return await FirebaseFirestore.instance.collection("Users").where("uid"==firebaseUser.uid).snapshots();
  }