import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:work_os/views/screens/home.dart';
import 'package:work_os/views/screens/login.dart';

class UserStatus {
  final GetStorage _box = GetStorage();
  final String _key = 'isLoging';

  void saveToBox(bool isloading) => _box.write(_key, isloading).then(
        (value) {
          log('Save value Success');
          return value;
        },
      ).catchError(
        (error) {
          log('Error');
        },
      );
  bool _loadFromBox() {
    return _box.read(_key) ?? false;
  }

  dynamic get page => _loadFromBox() ? const HomeScreen() : const LoginScreen();
}
