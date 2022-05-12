import 'package:bulutegitim/screens/home/home_web.dart';
import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:firebase_auth/firebase_auth.dart';


class WebHomePage extends StatefulWidget {
  const WebHomePage({ Key? key }) : super(key: key);

  @override
  State<WebHomePage> createState() => _WebHomePageState();
}

class _WebHomePageState extends State<WebHomePage> {
  String? _value;

  @override
  Widget build(BuildContext context) {
  final auth = FirebaseAuth.instance;
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
              selectedTitleTextStyle: TextStyle(color: Colors.white),
              selectedIconColor: Colors.white,
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.all(Radius.circular(10)),
              // ),
              // backgroundColor: Colors.blueGrey[700]
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
                  page.jumpToPage(0); Navigator.pop(context);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const WebHomePage()));
              
                },
                icon: Icon(Icons.home),
                badgeContent: Text(
                  '3',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SideMenuItem(
                priority: 1,
                title: 'Profil',
                onTap: () {
                  page.jumpToPage(1);
                },
                icon: Icon(Icons.supervisor_account),
              ),
              SideMenuItem(
                priority: 2,
                title: 'Kurslar',
                onTap: () {
                  page.jumpToPage(2);
                },
                icon: Icon(Icons.file_copy_rounded),
              ),
              SideMenuItem(
                priority: 3,
                title: 'Notlar',
                onTap: () {
                  page.jumpToPage(3);
                },
                icon: Icon(Icons.note_add),
              ),
              SideMenuItem(
                priority: 4,
                title: 'Ayarlar',
                onTap: () {
                  page.jumpToPage(4);
                },
                icon: Icon(Icons.settings),
              ),
              SideMenuItem(
                priority: 6,
                title: 'Çıkış',
                onTap: () async {
                  await auth.signOut();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomeWebScreen()));},
                icon: Icon(Icons.exit_to_app),
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: page,
              children: [
                Container(
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      'Dashboard',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      'Users',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      'Files',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      'Download',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      'Settings',
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