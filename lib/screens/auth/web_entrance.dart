import 'package:bulutegitim/net/firebase.dart';
import 'package:bulutegitim/screens/home/home_web.dart';
import 'package:bulutegitim/screens/pages/admin.dart';
import 'package:bulutegitim/screens/pages/anasayfa_web.dart';
import 'package:bulutegitim/screens/pages/profile_web.dart';
import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../pages/course_upload_web.dart';


class WebEnterancePage extends StatefulWidget {
  const WebEnterancePage({ Key? key }) : super(key: key);

  @override
  State<WebEnterancePage> createState() => _WebEnterancePageState();
}

class _WebEnterancePageState extends State<WebEnterancePage> {
  String? _value;

  @override
  Widget build(BuildContext context) {
  final auth = FirebaseAuth.instance;
  String role;

  /*                    FutureBuilder(
                        future: readUser(),
                        builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot){
                          if(snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData){
                              return Text(snapshot.data!['roles']);
                            }
                          return Container();
                        }),*/

  var screenSize = MediaQuery.of(context).size;

    PageController page = PageController();
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
                const Icon(    Icons.cloud_outlined),
                      SizedBox(width: screenSize.width / 60),
                const Text('Bulut Eğitim'),
                      SizedBox(width: screenSize.width / 20),
        DropdownButton<String>(
          hint:const Text("Kategoriler"),
        value: _value,
        items: const <DropdownMenuItem<String>>[
           DropdownMenuItem(
            child:  Text('Amazon Web Services'),
            value: 'AWS',
          ),
           DropdownMenuItem(
            child:  Text('Microsoft Azure'),
            value: 'MicrosoftAzure',
          ), DropdownMenuItem(
            child:  Text('Google Cloud Platform'),
            value: 'GoogleCloudPlatform',
          ), DropdownMenuItem(
            child: Text('Alibaba Cloud'),
            value: 'AlibabaCloud',
          ), DropdownMenuItem(
            child: Text('Big Data'),
            value: 'BigData',
          ), DropdownMenuItem(
            child: Text('Business Management'),
            value: 'BusinessManagement',
          ), DropdownMenuItem(
            child: Text('Cloud Computing Fundamentals'),
            value: 'CloudComputingFundamentals',
          ),
        ], 
        onChanged: (String? value) {
          setState(() => _value = value);
        },
      ),
                    ],
                  ),
                ),
                Container(child: FutureBuilder(
            //Bu fonksiyon firestore'dan data çekmeyi görebilmek için sonradan eklendi
            future: getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done)
                return Text("Loading data...Please wait");
              return Text("Merhaba $displayName  ");
            },
          ),),        
          FutureBuilder(
                        future: readUser(),
                        builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot){
                          if(snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData){
                              role=snapshot.data!['roles']; 
                              if(role=="admin") {       
                              return Row(
                                children: [
                                  InkWell(
                                  onTap: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AdminPage()));},
                                  child: const Text(
                                  "Admin",
                                  style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                SizedBox(
                                width: 10,
                                )],
                              );}
                              return SizedBox(width: 5,);
                            }
                          return Container();
                        }), 
                       
                      InkWell(
                        onTap: () {},
                        child: const Text(
                          "İletişim",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SideMenu(
            controller: page,
            style: SideMenuStyle(
              displayMode: SideMenuDisplayMode.auto,
              hoverColor: Colors.blue[100],
              selectedColor: Colors.lightBlue,
              selectedTitleTextStyle: const TextStyle(color: Colors.white),
              selectedIconColor: Colors.white,
            ),
            title: Column(
              children: [
                Divider(
                  indent: 8.0,
                  endIndent: 8.0,
                ),
              ],
            ),
            footer: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Bulut Eğitim',
                style: TextStyle(fontSize: 15),
              ),
            ),
            items: [
              SideMenuItem(
                priority: 0,
                title: 'Anasayfa',
                onTap: () {
                  page.jumpToPage(0);
                },
                icon: const Icon(Icons.home),
                badgeContent: const Text(
                  '3',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SideMenuItem(
                priority: 1,
                title: 'Kurslar',
                onTap: () {
                  page.jumpToPage(1);
                },
                icon: const Icon(Icons.supervisor_account),
              ),
              SideMenuItem(
                priority: 2,
                title: 'Profil',
                onTap: () {
                  page.jumpToPage(2);
                },
                icon: const Icon(Icons.file_copy_rounded),
              ),
              SideMenuItem(
                priority: 3,
                title: 'Ayarlar',
                onTap: () {
                  page.jumpToPage(3);
                },
                icon: const Icon(Icons.settings),
              ),
              SideMenuItem(
                priority: 4,
                title: 'Çıkış',
                onTap: () async {
                  await auth.signOut();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomeWebScreen()));},
                icon: const Icon(Icons.exit_to_app),
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: page,
              children: [
                Anasayfa_web(),
                          FutureBuilder(
                        future: readUser(),
                        builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot){
                          if(snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData){
                              role=snapshot.data!['roles']; 
                              if(role=="instructor") {       
                              return WebUploadPage();
                            }
                          return Anasayfa_web();
                        }
                        else {return Anasayfa_web();}
                        }), 
                ProfileWeb(),
                Container(
                  color: Colors.white,
                  child: Text("Ayarlar"),
                ),
                Container(
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      'Çıkış',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}