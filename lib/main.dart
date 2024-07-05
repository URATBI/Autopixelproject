import 'package:autopixel/login/login.dart';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'camera/camera.dart';
import 'chatroom/chatbox.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'AutoPixel',
      home: MyHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          leading: Image.asset(
            "asset/logos.png",
            width: 10,
            height: 5,
          ),
          backgroundColor: Color.fromARGB(255, 234, 233, 233),
          title: const Text(
            "AutoPixel",
            style: TextStyle(color: Color.fromARGB(255, 35, 35, 35)),
          ),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CameraPage()), // Navigate to CameraPage
                  );
                },
                icon: const Icon(
                  Icons.camera_enhance,
                  color: Color.fromARGB(255, 35, 35, 35),
                ))
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Card(
              color: Color.fromARGB(255, 226, 226, 226),
              child: ListTile(
                leading: const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage("asset/IT.jpg"),
                ),
                title: const Text(
                  "IT-SJCE",
                  style: TextStyle(
                      color: Colors.black,
                      fontStyle: FontStyle.normal,
                      fontSize: 15,
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Login()), // Navigate to CameraPage
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
