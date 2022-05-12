import 'package:bulutegitim/screens/auth/sign_in_mobile.dart';
import 'package:bulutegitim/screens/pages/main_home_web.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class NavDrawer extends StatelessWidget {
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
                      "Profil",
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
            title: Text("Anasayfa"),
            leading: IconButton(
              icon: Icon(Icons.dashboard_outlined),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => WebHomePage())); 
              },
            ),
            onTap: ()
            {
              /*Navigator.of(context).pop();
               Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => MyHomePage())); */
            },
          ),
          Divider(
            color: Colors.grey,
          ),
          ListTile(
            title: Text("Kurslar"),
            leading: IconButton(
              icon: Icon(Icons.file_copy_rounded),
              onPressed: () {
              },
            ),
            onTap: ()
            {
              /*Navigator.of(context).pop();
               Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => profile())); */
            },
          ),
          Divider(
            color: Colors.grey,
          ),
          ListTile(
            title: Text("İletişim"),
            leading: IconButton(
              icon: Icon(Icons.contact_page),
              onPressed: () {
              },
            ),
            onTap: ()
             {
              /* Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => contact())); */
              },
          ),
            Divider(
            color: Colors.grey,
          ),
          ListTile(
            title: Text("Notlar"),
            leading: IconButton(
              icon: Icon(Icons.note),
              onPressed: () {
              },
            ),
            onTap: ()
             {
              /* Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => contact())); */
              },
          ),
            Divider(
            color: Colors.grey,
          ),
          ListTile(
            title: Text("Ayarlar"),
            leading: IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
              },
            ),
            onTap: ()
             {
              /* Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => contact())); */
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
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const SignInScreen()));
              },
            ),
            onTap: () 
             async{
               await auth.signOut();
               Navigator.pop(context);
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const SignInScreen()));
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