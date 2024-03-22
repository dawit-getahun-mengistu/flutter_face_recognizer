import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:objectdetectionapp/home.dart';
import 'package:objectdetectionapp/screens/camera_app.dart';

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();

  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // primaryColor: Colors.purple.shade900,
        primaryColor: Colors.teal,
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(
          // backgroundColor: Colors.purple.shade900,
          backgroundColor: Colors.black,
        ),
      ),
      // home: CameraAPP(cameras),
      home: const Home(),
    );
  }
}
