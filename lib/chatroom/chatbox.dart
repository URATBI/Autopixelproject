import 'dart:io';

import 'package:autopixel/chatroom/imagePage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageListScreen extends StatefulWidget {
  @override
  _ImageListScreenState createState() => _ImageListScreenState();
}

class _ImageListScreenState extends State<ImageListScreen> {
  List<String> imageUrls = [];

  @override
  void initState() {
    super.initState();
    loadImages();
  }

  Future<void> loadImages() async {
    firebase_storage.ListResult result = await firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('image')
        .listAll();

    for (firebase_storage.Reference ref in result.items) {
      String downloadURL = await ref.getDownloadURL();
      setState(() {
        imageUrls.add(downloadURL);
        imageUrls.reversed.toList();
        print(imageUrls);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 234, 233, 233),
        title: const Text(
          'IT-SJCE ImageBox',
          style: TextStyle(
            color: Color.fromARGB(255, 35, 35, 35),
            fontStyle: FontStyle.normal,
            fontSize: 15,
            fontFamily: 'Arial',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: imageUrls.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onDoubleTap: () {
              String imageUrl = imageUrls.reversed.toList()[index];
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ImagePage(imageUrl)),
              );
            },
            child: Stack(
              children: [
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  width: 250,
                  height: 300,
                  margin: EdgeInsets.all(10.0),
                  child: Center(
                    child: Image.network(
                      imageUrls.reversed.toList()[index],
                      fit: BoxFit.cover,
                      height: 300,
                      width: 200,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 234, 233, 233),
        onPressed: () async {
          final picker = ImagePicker();
          final XFile? pickedImage =
              await picker.pickImage(source: ImageSource.gallery);

          if (pickedImage != null) {
            File imageFile = File(pickedImage.path);
            String fileName = DateTime.now().millisecondsSinceEpoch.toString();
            firebase_storage.Reference ref = firebase_storage
                .FirebaseStorage.instance
                .ref()
                .child('image/$fileName.jpg');

            await ref.putFile(imageFile);

            String downloadURL = await ref.getDownloadURL();
            print("Download URL: $downloadURL");
          }
        },
        child: const Icon(
          Icons.add,
          color: Color.fromARGB(255, 34, 34, 34),
        ),
      ),
    );
  }
}
