import 'dart:convert';

import 'package:autopixel/chatroom/chatbox.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final DatabaseReference _datas =
      FirebaseDatabase.instance.ref().child('code');
  final TextEditingController _controller = TextEditingController();
  String _datacode = '';
  List<String> list = ['good', 'iyt'];
  // Get the current text value
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    _readData();
  }

  void _readData() async {
    var url =
        "https://autopixel-75f39-default-rtdb.asia-southeast1.firebasedatabase.app/" +
            "data.json";

    // (Do not remove “data.json”,keep it as it is)
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      extractedData.forEach((blogId, blogData) {
        setState(() {
          _datacode = blogData["title"];
        });
      });
    } catch (error) {
      throw error;
    }
  }

  void _showPopupG(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Invalid Code',
            style: TextStyle(
                color: Color.fromARGB(255, 231, 19, 19), fontSize: 25),
          ),
          content: Text(
            'Group Code is wrong please Enter Correct Code!',
            style: TextStyle(fontSize: 15),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('ok'),
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 243, 243, 243)),
            height: 350,
            width: double.infinity,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const CircleAvatar(
                  radius: 55,
                  backgroundImage: AssetImage("asset/IT.jpg"),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Center(
                    child: Text(
                  "IT-Sjce",
                  style: TextStyle(
                      color: Colors.black,
                      fontStyle: FontStyle.normal,
                      fontSize: 20,
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.bold),
                )),
                const SizedBox(
                  height: 20,
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: 500,
                    maxWidth: 500,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                          hintText: 'GROUP CODE',
                          labelText: 'CODE',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    String codes = _datacode;
                    if (_controller.text == codes) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ImageListScreen()), // Navigate to CameraPage
                      );
                    } else {
                      _showPopupG(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(
                        255, 235, 235, 235), // Background color

                    padding: const EdgeInsets.all(12), // Padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Border radius
                    ),
                  ),
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Color.fromARGB(255, 36, 36, 36)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
