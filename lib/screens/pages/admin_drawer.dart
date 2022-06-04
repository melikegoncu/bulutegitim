import 'package:bulutegitim/screens/home/home_web.dart';
import 'package:bulutegitim/screens/pages/admin_messages.dart';
import 'package:bulutegitim/screens/pages/admin_videos.dart';
import 'package:bulutegitim/screens/pages/anasayfa_web.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';



class AdminDrawer extends StatelessWidget {
  const AdminDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    return Drawer(
      child:ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Center(
              child: Row(
                children: [
                  Expanded(
                    child: Icon(Icons.account_circle, color: Colors.white,size: 40,),
                    flex: 2,
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      "Menu",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: const Text("Videolar"),
            leading: IconButton(
              icon: const Icon(Icons.video_file),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => AdminVideos())); 
              },
            ),
            onTap: ()
             {
Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => AdminVideos())); 
              },
          ),
            Divider(
            color: Colors.grey,
          ),
          ListTile(
            title: const Text("Mesajlar"),
            leading: IconButton(
              icon: const Icon(Icons.contact_page),
              onPressed: () {
                
               Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ListComment())); 
              },
            ),
            onTap: ()
             {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ListComment())); 
              },
          ),
            Divider(
            color: Colors.grey,
          ),
          
          ListTile(
            title: Text("Çıkış"),
            leading: IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () { Navigator.pop(context);
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomeWebScreen()));
              },
            ),
            onTap: () 
             async{
               await auth.signOut();
               Navigator.pop(context);
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomeWebScreen()));
              },
          ),
            Divider(
            color: Colors.grey,
          ),
        ],
      ) ,
    );
  }
}