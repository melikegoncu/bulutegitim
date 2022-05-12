import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> userSetup(String displayName, {roles = "student"}) async {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser!.uid.toString();
  users.add({'displayName': displayName, 'uid': uid, 'roles': roles});
  return;
}
// Future<void> roleUpdate({roles = "teacher"}) async {
//   CollectionReference users = FirebaseFirestore.instance.collection('Users');
//   FirebaseAuth auth = FirebaseAuth.instance;
//   String uid = auth.currentUser!.uid.toString();
//   users.add({'roles': roles});
//   return;
// }
