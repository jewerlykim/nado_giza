import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:nado_giza/repository/firebase_login_repository.dart';

class LoginViewmodel extends ChangeNotifier {
  final firebaseLoginRepository = FirebaseLoginRepository();

  String email = '';
  String password = '';

  void updateEmail(String email) {
    this.email = email;

    notifyListeners();
  }

  void updatePassword(String password) {
    this.password = password;
    notifyListeners();
  }

  Future<bool> signUp(String email, String password) async {
    try {
      await firebaseLoginRepository.signUp(email, password);
    } catch (e) {
      throw Exception(e);
    }
    return true;
  }

  Future<String?> signIn(String email, String password) async {
    try {
      final isSuccess = await firebaseLoginRepository.signIn(email, password);
      if (kDebugMode) {
        print('로그인 성공 여부 viewmodel: $isSuccess email : $email');
      }
    } catch (e) {
      return e.toString();
    }
    return null;
  }

  // 로그아웃
  Future<void> signOut() async {
    if (kDebugMode) {
      print('로그아웃');
    }
    await firebaseLoginRepository.signOut();
  }

  // 현재 유저 정보 조회
  User? getCurrentUser() {
    return firebaseLoginRepository.getCurrentUser();
  }
}