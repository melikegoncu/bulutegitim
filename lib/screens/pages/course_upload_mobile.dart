import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'mobile_drawer.dart';
class MobilUploadPage extends StatefulWidget {
  const MobilUploadPage({Key? key}) : super(key: key);

  @override
  State<MobilUploadPage> createState() => _MobilUploadPageState();
}

class _MobilUploadPageState extends State<MobilUploadPage> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;

Future selectFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.video,
    allowMultiple: false
  );
  if (result == null) return;

  setState(() {
    pickedFile= result.files.first;
  });
}
  Future uploadFile() async{
    final path = 'courses/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    setState(() {
    uploadTask= ref.putFile(file);
});

    final snapshot =await uploadTask!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download Link: $urlDownload');

    setState(() {
      uploadTask=null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Bulut Eğitim")
        ),
        body: Center(
      child: Column(
        children: [
          if (pickedFile != null)
          Expanded(
            child: Container(
            child:  Text(pickedFile!.name)
          )),
          SizedBox(height: 10,),
          const Text("Kurs ekleyin"),
          SizedBox(height: 10,),

          ElevatedButton(onPressed: selectFile, child: const Text("Seç")),
          SizedBox(height: 10,),

          ElevatedButton(onPressed: uploadFile, child: const Text("Yükle")),
          SizedBox(height: 10,),

          buildProgress(),

        ],
      ),
    ),
        drawer: NavDrawer()
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