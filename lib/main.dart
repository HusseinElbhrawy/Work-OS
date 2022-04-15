import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_os/utils/const/const.dart';
import 'package:work_os/utils/services/user_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static final Future<FirebaseApp> _initFirebase = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initFirebase,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text(
                'Error Happened !',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: kDarkBlue,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          );
        }
        return GetMaterialApp(
          title: 'Work OS',
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              color: kScaffoldBGColor,
              elevation: 0.0,
              iconTheme: IconThemeData(color: kDarkBlue),
            ),
            scaffoldBackgroundColor: kScaffoldBGColor,
            primarySwatch: Colors.blue,
          ),
          home: UserState(),
        );
      },
    );
  }
}
