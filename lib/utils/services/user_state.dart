import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '/utils/const/const.dart';
import '/views/screens/home.dart';
import '/views/screens/login.dart';

class UserState extends StatelessWidget {
  const UserState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const HomeScreen();
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
        return LoginScreen();
      },
    );
  }
}
