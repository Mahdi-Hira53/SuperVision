import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login/utility/constant_login.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';

class RoutinePage extends StatefulWidget {
  const RoutinePage({Key? key}) : super(key: key);

  @override
  State<RoutinePage> createState() => _RoutinePageState();
}

class _RoutinePageState extends State<RoutinePage> {
  PlatformFile? pickedFile;
  String? url;

  void getFile() {
    FirebaseFirestore.instance
        .collection("routine")
        .doc("image-details")
        .get()
        .then((value) {
      url = value["image_name"];
      setState(() {
        url = url;
      });
    });
  }

  void initState() {
    getFile();
    super.initState();
  }

  Future uploadFile() async {
    try {
      final path = '/routine/${pickedFile!.name}';
      final file = File(pickedFile!.path!);
      final ref = FirebaseStorage.instance.ref().child(path);
      ref.putFile(file).whenComplete(() async {
        url = await ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection("routine")
            .doc("image-details")
            .set({"image_name": url});
        getFile();
        pickedFile = null;
      });
      const SnackBar snackBar =
          SnackBar(content: Text('File Uploaded Successfully'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } on FirebaseException catch (e) {
      const SnackBar snackBar =
          SnackBar(content: Text('File Uploading is failed'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      print(e);
    }
  }

  Future selectFile() async {
    try {
      final result = await FilePicker.platform.pickFiles();
      if (result == null) return;
      setState(() {
        pickedFile = result.files.first;
      });
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            url != null
                ? Image.network(
                    url!,
                    width: 400,
                    height: 500,
                    fit: BoxFit.cover,
                  )
                : Text(
                    ""
                  ),
            pickedFile != null ? Text(pickedFile!.name) : const Text(""),
          ],
        ),
      ),
      floatingActionButton: Wrap(
        verticalDirection: VerticalDirection.up,
        direction: Axis.horizontal,
        alignment: WrapAlignment.spaceAround,
        spacing: 250,
        crossAxisAlignment: WrapCrossAlignment.end,
        children: [
          FloatingActionButton(
            tooltip: "Select",
            backgroundColor: kButtonColor,
            onPressed: selectFile,
            child: Icon(Icons.select_all_outlined),
          ),
          FloatingActionButton(
            tooltip: "Upload",
            backgroundColor: kButtonColor,
            onPressed: pickedFile != null ? uploadFile : (){},
            child: Icon(Icons.upload),
          ),
        ],
      ),
    );
  }
}
