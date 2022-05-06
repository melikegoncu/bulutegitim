import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                      "Profile",
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
            title: Text("Dashboard"),
            leading: IconButton(
              icon: Icon(Icons.dashboard_outlined),
              onPressed: () {
                Navigator.of(context).pop();
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
            title: Text("Courses"),
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
            title: Text("Contact"),
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
            title: Text("Notes"),
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
            title: Text("Settings"),
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
            title: Text("Exit"),
            leading: IconButton(
              icon: Icon(Icons.exit_to_app),
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
        ],
      ) ,
    );
  }
}