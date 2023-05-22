import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nado_giza/repository/firebase_login_repository.dart';
import 'package:nado_giza/viewModel/login_viewmodel.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  // Create controllers for the text fields.
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // 로그인 처리를 위한 메서드
    Future<void> handleLogin() async {
      final provider = Provider.of<LoginViewmodel>(context, listen: false);
      final result =
          await provider.signIn(emailController.text, passwordController.text);

      if (kDebugMode) {
        print('로그인 결과: $result');
      }

      // 로그인 실패
      if (result != null) {
        // ignore: use_build_context_synchronously
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result),
          ),
        );
      }
      // 로그인 성공
      else {
        // ignore: use_build_context_synchronously
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('로그인 성공'),
          ),
        );
        // navigate to home page
        Navigator.pushReplacementNamed(context, '/home');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('로그인'),
      ),
      body: Consumer<LoginViewmodel>(
        builder: (context, provider, child) {
          if (kDebugMode) {
            print(
                '1로그인뷰에서 로그인 상태 확인: ${FirebaseLoginRepository.instance().getIsSignedIn}');
          }
          // 1초 후에
          Future.delayed(const Duration(seconds: 1));
          // 로그인 상태 확인
          if (FirebaseLoginRepository.instance().getIsSignedIn) {
            if (kDebugMode) {
              print(
                  '2로그인뷰에서 로그인 상태 확인: ${FirebaseLoginRepository.instance().getIsSignedIn}');
            }
            // 사용자가 이미 로그인한 경우 홈 화면으로 이동
            Future.microtask(
              () => {
                Navigator.pushReplacementNamed(context, '/home'),
              },
            );
          } else {
            if (kDebugMode) {
              print(
                  '3로그인뷰에서 로그인 상태 확인: ${FirebaseLoginRepository.instance().getIsSignedIn}');
            }
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  onChanged: provider.updateEmail,
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: '이메일',
                  ),
                ),
                const SizedBox(height: 16.0), // Provide some vertical spacing
                TextField(
                  onChanged: provider.updatePassword,
                  controller: passwordController,
                  obscureText: true, // Use secure text for password.
                  decoration: const InputDecoration(
                    labelText: '패스워드',
                  ),
                  onSubmitted: (value) {
                    handleLogin();
                  },
                ),
                const SizedBox(height: 30.0), // Provide some vertical spacing

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: const Text('로그인'),
                      onPressed: () {
                        if (kDebugMode) {
                          print("로그인");
                        }
                        handleLogin();
                      },
                    ),
                    const SizedBox(
                        width: 16.0), // Provide some horizontal spacing
                    ElevatedButton(
                      child: const Text('회원가입'),
                      onPressed: () {
                        if (kDebugMode) {
                          print("회원가입");
                        }
                        Navigator.pushNamed(context, '/signup');
                      },
                    ),

                    const SizedBox(width: 16.0),
                    ElevatedButton(
                      child: const Text('유저정보 확인'),
                      onPressed: () async {
                        provider.getCurrentUser();
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
