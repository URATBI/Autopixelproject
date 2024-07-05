import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';

class ImagePage extends StatelessWidget {
  final String imageUrl;

  ImagePage(this.imageUrl);

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Image'),
          content: Text('This Image was Saved in Gallery'),
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 234, 233, 233),
        title: const Text('Image Detail',
            style: TextStyle(
              color: Color.fromARGB(255, 35, 35, 35),
              fontStyle: FontStyle.normal,
              fontSize: 15,
              fontFamily: 'Arial',
              fontWeight: FontWeight.bold,
            )),
        actions: [
          IconButton(
              onPressed: () {
                String Url = imageUrl;
                GallerySaver.saveImage(Url);
                _showPopup(context);
              },
              icon: const Icon(
                Icons.save_outlined,
                color: Color.fromARGB(255, 34, 34, 34),
              ))
        ],
      ),
      body: Center(
        child: InteractiveViewer(
          boundaryMargin: EdgeInsets.all(20.0),
          minScale: 0.1,
          maxScale: 4.0,
          child: Image.network(imageUrl),
        ),
      ),
    );
  }
}
