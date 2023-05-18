import 'package:firebase_auth/firebase_auth.dart';

class FirebaseLoginRepository {
  // 초기화
  FirebaseLoginRepository();

  // 회원가입
  Future<bool> signUp(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('비밀번호가 너무 약합니다.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('이미 사용중인 이메일입니다.');
      }
    } catch (e) {
      throw Exception('회원가입에 실패했습니다. ${e.toString()}');
    }
    return true;
  }
}
