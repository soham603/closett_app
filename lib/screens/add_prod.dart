import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UploadVideo extends StatefulWidget {
  const UploadVideo({super.key});

  @override
  State<UploadVideo> createState() => _UploadVideoState();
}

// I have used a step by step mechanism where i will first pick file be file_picker and then upload

class _UploadVideoState extends State<UploadVideo> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  final User? currentUser = FirebaseAuth.instance.currentUser;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,    // For only one video at a time
      type: FileType.image,   // For only videos to be selected
    );
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future uploadFile() async {
    if (pickedFile == null) {
      return;
    }

    final path = '${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    // Upload video to Firebase Storage
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceUploads = referenceRoot.child('Videos');
    Reference referenceVideoToUpload = referenceUploads.child(path);

    setState(() {
      uploadTask = referenceVideoToUpload.putFile(file);
    });

    // Uploading time
    await uploadTask!.whenComplete(() {});

    // I am getting the downloaded url and sending with title and description to firebase firestore
    final urlDownload = await referenceVideoToUpload.getDownloadURL();
    print(urlDownload);

    // Storing all details in firestore

    await FirebaseFirestore.instance.collection('users').doc(currentUser?.uid).collection('outfits').add({
      'title': titleController.text,
      'description': descriptionController.text,
      'image': urlDownload,
    });

    FirebaseFirestore.instance.collection('outfits').add({
      'title': titleController.text,
      'description': descriptionController.text,
      'image': urlDownload,
    });

    // after upload setting controllers to null for next upload
    setState(() {
      uploadTask = null;
      pickedFile = null;
      titleController.clear();
      descriptionController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Upload Video"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (pickedFile != null)
              Expanded(
                child: Container(
                  height: 200,
                  color: Colors.blue[100],
                  child: Center(
                    child: Text(pickedFile!.name),
                  ),
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: selectFile,
              child: const Text("Select Files"),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25),
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25),
              child: TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: uploadFile,
              child: const Text("Upload Files"),
            ),
            const SizedBox(height: 5),
            buildProgress(uploadTask),
          ],
        ),
      ),
    );
  }
}

Widget buildProgress(UploadTask? uploadTask) => StreamBuilder<TaskSnapshot>(
  stream: uploadTask?.snapshotEvents,
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      final data = snapshot.data!;
      double progress = data.bytesTransferred / data.totalBytes;

      return SizedBox(
        height: 50,
        child: Stack(
          fit: StackFit.expand,
          children: [
            LinearProgressIndicator(
              color: Colors.green,
              backgroundColor: Colors.grey,
              value: progress,
            ),
            Center(
              child: Text(
                '${(100 * progress).roundToDouble()}%',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    } else {
      return const SizedBox(height: 50);
    }
  },
);
