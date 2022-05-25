import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
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
  Future uploadFile() async{
    try{
    Uint8List? fileBytes = pickedFile!.bytes;
    String? fileName = pickedFile?.name;
    
    final ref = FirebaseStorage.instance.ref('courses/$fileName');
    setState(() {
    uploadTask= ref.putData(fileBytes!);
});

    final snapshot =await uploadTask!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download Link: $urlDownload');

    setState(() {
      uploadTask=null;
    });
    }
    catch(e){
      print('error in uploading image for : ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          // if (pickedFile != null)
          // Expanded(
          //   child: Container(
          //   child:  Image.memory(pickedFile!.bytes!)
          // )),
          SizedBox(height: 10,),
          const Text("Kurs ekleyin"),
          SizedBox(height: 10,),

          ElevatedButton(onPressed: selectFile, child: const Text("Seç")),
          SizedBox(height: 10,),

          ElevatedButton(onPressed: uploadFile, child: const Text("Yükle")),
          SizedBox(height: 10,),

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