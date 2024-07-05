import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';

class Imagepic extends StatefulWidget {
  Imagepic(this.file, {super.key});
  XFile file;

  @override
  State<Imagepic> createState() => _ImagepicState();
}

class _ImagepicState extends State<Imagepic> {
  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Image'),
          content: const Text('This Image was Saved in Gallery'),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showPopupG(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Uploaded'),
          content: Text('Image was Uploaded in IT-Group'),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    File Picture = File(widget.file.path);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 234, 233, 233),
        title: const Text("Image pic",
            style: TextStyle(
              color: Color.fromARGB(255, 35, 35, 35),
              fontStyle: FontStyle.normal,
              fontSize: 15,
              fontFamily: 'Arial',
              fontWeight: FontWeight.bold,
            )),
        actions: <Widget>[
          IconButton(
              onPressed: () async {
                String filePath = Picture.path;
                GallerySaver.saveImage(filePath);
                _showPopup(context);
              },
              icon:
                  Icon(Icons.download, color: Color.fromARGB(255, 35, 35, 35))),
          IconButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  barrierDismissible: false,
                );
                String fileName =
                    DateTime.now().millisecondsSinceEpoch.toString();
                firebase_storage.Reference ref = firebase_storage
                    .FirebaseStorage.instance
                    .ref()
                    .child('image/$fileName.jpg');

                await ref.putFile(Picture);

                String downloadURL = await ref.getDownloadURL();
                print("Download URL: $downloadURL");
                Navigator.pop(context);
                _showPopupG(context);
              },
              icon: Icon(
                Icons.send_outlined,
                color: Color.fromARGB(255, 35, 35, 35),
              ))
        ],
      ),
      backgroundColor: Color.fromARGB(255, 187, 186, 186),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Image.file(Picture),
        ),
      ),
    );
  }
}
