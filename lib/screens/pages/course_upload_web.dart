import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../net/firebase.dart';
class WebUploadPage extends StatefulWidget {
  const WebUploadPage({Key? key}) : super(key: key);

  @override
  State<WebUploadPage> createState() => _WebUploadPageState();
}

class _WebUploadPageState extends State<WebUploadPage> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;

Future selectFile() async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.video,
    allowMultiple: false
  );
  if (result == null) return;

  setState(() {
    pickedFile= result.files.first;
  });
}
  Future uploadFile(String videoName, String description, String categories) async{
    try{
    Uint8List? fileBytes = pickedFile!.bytes;
    String? fileName = pickedFile?.name;
    
    final ref = FirebaseStorage.instance.ref('courses/$fileName');
    setState(() {
    uploadTask= ref.putData(fileBytes!);
});

    final snapshot =await uploadTask!.whenComplete(() {});
     var firebaseUser = auth.currentUser!;
    String? instructorName= firebaseUser.displayName;

    final urlDownload = await snapshot.ref.getDownloadURL();
    videoSetup(urlDownload, videoName, instructorName!, description, categories);

    print('Download Link: $urlDownload');

    setState(() {
      uploadTask=null;
    });
    }
    catch(e){
      print('error in uploading image for : ${e.toString()}');
    }
  }
  String? _value;

  @override
  Widget build(BuildContext context) {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _videoNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
    return Center(
      child: Column(
        children: [
          Container(
            child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                  child: DropdownButton<String>(
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
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: 
                  FloatingActionButton.extended(
                    heroTag: "pick",
                    backgroundColor: Colors.amber,
                    label: Text('Seç',
                    textAlign: TextAlign.center),
                    onPressed: ()async{
                      try {
                        selectFile();
                      } catch (e) {
                        
                      }
                  }),
                            
                                ),
          //                       Padding(
          //                         padding: const EdgeInsets.all(8.0),
          //                         child: (pickedFile != null) ? Expanded(
          //   child: Container(
          //   child:  Text(pickedFile!.name)
          // )): Container(),
          //                       ),

                                Padding(padding: const EdgeInsets.all(8.0),
                                child:TextFormField(
                                  validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen kurs ismi giriniz.';
                  }
                  return null;
                },
                      controller: _videoNameController,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(  
                      prefixIcon: Icon(Icons.label),
                      hintText: 'Video İsmi'
                      ),
                    ),),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen açıklama giriniz.';
                  }
                  return null;
                },
                    controller: _descriptionController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(  
                      hintText: 'Açıklama',
                      prefixIcon: Icon(Icons.description)
                    ),
                      ),
                                ),
                                
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: 
                  FloatingActionButton.extended(
                    heroTag: "upload",
                    backgroundColor: Colors.amber,
                    label: Text('Yükle',
                    textAlign: TextAlign.center),
                    onPressed: ()async{
                      if(_formKey.currentState!.validate() && pickedFile != null && _value!=null ){
                      try {
                        uploadFile(_videoNameController.text, _descriptionController.text, _value.toString());
                      } catch (e) {
                        
                      }
                      }
                  }),
                                ),
                              ],
                            ),
                          ),
          ),
          Container(child: buildProgress()),
        ],
      ),
    );
  }
    Widget buildProgress() => StreamBuilder<TaskSnapshot>(
    stream: uploadTask?.snapshotEvents,
    builder: (context,snaphot){
      if(snaphot.hasData){
        final data =snaphot.data!;
        double progress= data.bytesTransferred / data.totalBytes;

        return SizedBox(
          height: 50,
          child: Stack(
            fit: StackFit.expand,
            children: [
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey,
                color: Colors.green,
              ),
              Center(child: Text(
                '${(100*progress).roundToDouble()}%',
                style: const TextStyle(color: Colors.white),
              ))
            ],
          ),
        );
      } else {
        return const SizedBox(height:50);
      }
    },);
}