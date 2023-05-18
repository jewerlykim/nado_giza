import 'package:flutter/material.dart';
import 'package:nado_giza/repository/firebase_login_repository.dart';

class LoginViewmodel extends ChangeNotifier {
  final firebaseLoginRepository = FirebaseLoginRepository();

  Future<bool> signUp(String email, String password) async {
    try {
      await firebaseLoginRepository.signUp(email, password);
    } catch (e) {
      throw Exception(e);
    }
    return true;
  }
}
