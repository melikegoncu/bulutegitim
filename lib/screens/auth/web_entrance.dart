import 'package:bulutegitim/net/firebase.dart';
import 'package:bulutegitim/screens/home/home_web.dart';
import 'package:bulutegitim/screens/pages/profile_web.dart';
import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:firebase_auth/firebase_auth.dart';


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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //_usernameController.text= readItems();

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
              selectedTitleTextStyle: const TextStyle(color: Colors.white),
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
                Container(
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      'Anasayfa',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      'Kurslar',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Center(
                    child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(padding: const EdgeInsets.all(8.0),
                            child:TextFormField(
                              validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Lütfen isim giriniz.';
              }
              return null;
            },
                  controller: _usernameController,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(  
                  prefixIcon: Icon(Icons.person),
                  hintText: 'Tam Ad'
                  ),
                ),),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Lütfen mail adresinizi giriniz.';
              }
              else if (!value.contains('@') && !value.contains('.com')) {
                return 'Geçersiz bir mail adresi girdiniz.';
              }
              return null;
            },
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(  
                  hintText: 'Email',prefixIcon: Icon(Icons.mail)
                ),
                  ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Lütfen bir şifre belirleyiniz.';
              }
              return null;
            },
                                controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(hintText: 'Şifre', prefixIcon: Icon(Icons.lock)),
                  ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: 
              FloatingActionButton.extended(
                heroTag: "login",
                backgroundColor: Colors.amber,
                label: Text('Güncelle',
                textAlign: TextAlign.center),
                onPressed: ()async{
                  if(_formKey.currentState!.validate()){
                  try {
                  // await auth.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
                  User updateUser = auth.currentUser!;
                  updateUser.updateDisplayName(_usernameController.text);
                  roleUpdate(_usernameController.text);
                  // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const WebEnterancePage()));
                  } on FirebaseAuthException catch (error) {
                  //Fluttertoast.showToast(msg: error.message!,gravity: ToastGravity.TOP,);
                  }}
              }),
                            ),
                          ],
                        ),
                      ),
                  ),
                ),
                ProfileWeb()
                ,
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