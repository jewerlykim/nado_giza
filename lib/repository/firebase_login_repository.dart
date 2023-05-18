import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

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

  // 로그인
  Future<bool> signIn(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        if (kDebugMode) {
          print("로그인 성공");
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('사용자를 찾을 수 없습니다.');
      } else if (e.code == 'wrong-password') {
        throw Exception('비밀번호가 틀렸습니다.');
      } else if (e.code == 'invalid-email') {
        throw Exception('이메일 형식이 잘못되었습니다.');
      } else if (e.code == 'user-disabled') {
        throw Exception('사용이 정지된 계정입니다.');
      } else if (e.code == 'too-many-requests') {
        throw Exception('너무 많은 요청이 들어왔습니다. 잠시 후 다시 시도해주세요.');
      } else if (e.code == 'operation-not-allowed') {
        throw Exception('사용이 정지된 계정입니다.');
      } else if (e.code == 'network-request-failed') {
        throw Exception('네트워크 연결이 끊겼습니다.');
      } else {
        throw Exception('로그인에 실패했습니다. ${e.toString()}');
      }
    } catch (e) {
      throw Exception('로그인에 실패했습니다. ${e.toString()}');
    }

    // 인증 영속
    // await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
    return true;
  }

  // 로그아웃
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  // 현재 유저 정보 조회
  User? getCurrentUser() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final name = user.displayName;
      final email = user.email;
      final photoUrl = user.photoURL;
      final emailVerified = user.emailVerified;
      final uid = user.uid;

      if (kDebugMode) {
        print('name: $name');
        print('email: $email');
        print('photoUrl: $photoUrl');
        print('emailVerified: $emailVerified');
        print('uid: $uid');
      }
      return user;
    }
    if (kDebugMode) {
      print('현재 유저 정보 없음');
    }

    return null;
  }
}