import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';

class LoginModel with ChangeNotifier {
  bool validateCredentials(String? email, String? password) {
    if (email == 'admin@gmail.com' && password == '12345') {
      return true; // Login berhasil
    }
    return false; // Login gagal
  }
}
