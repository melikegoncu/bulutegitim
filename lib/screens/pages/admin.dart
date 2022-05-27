import 'package:bulutegitim/screens/pages/admin_drawer.dart';
import 'package:bulutegitim/screens/pages/profile_web.dart';
import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../home/home_web.dart';
import 'anasayfa_web.dart';
import 'course_upload_web.dart';
import 'mobile_drawer.dart';



class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    PageController page = PageController();
    final auth = FirebaseAuth.instance;

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
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        
      ),
      drawer: AdminDrawer(),
    );
  }
}