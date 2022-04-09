import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_os/views/screens/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Work OS',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xffede7dc),
        primarySwatch: Colors.blue,
      ),
      home: SignUpScreen(),
    );
  }
}
