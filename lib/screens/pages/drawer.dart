import 'package:bulutegitim/screens/auth/sign_in_mobile.dart';
import 'package:bulutegitim/screens/auth/web_entrance.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

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
            title: const Text("Anasayfa"),
            leading: IconButton(
              icon: const Icon(Icons.dashboard_outlined),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const WebEnterancePage())); 
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
            title: const Text("Kurslar"),
            leading: IconButton(
              icon: const Icon(Icons.file_copy_rounded),
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
            title: const Text("İletişim"),
            leading: IconButton(
              icon: const Icon(Icons.contact_page),
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
            title: const Text("Notlar"),
            leading: IconButton(
              icon: const Icon(Icons.note),
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
            title: const Text("Ayarlar"),
            leading: IconButton(
              icon: const Icon(Icons.settings),
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