import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/Pages/camerascreen.dart';
import 'package:whatsapp/Screens/HomeScreen.dart';
import 'package:whatsapp/Screens/login.dart';

Future<void> main() async {
 //WidgetsFlutterBinding.ensureInitialized();
 //cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "OpenSans",
        primaryColor: const Color(0xFF075E54), colorScheme: ColorScheme.fromSwatch().copyWith(secondary:const Color(0xff128c7e)),
      ),
      home: const Login(),
    );
  }
}