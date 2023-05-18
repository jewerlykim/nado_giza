import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nado_giza/viewModel/login_viewmodel.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  // Create controllers for the text fields.
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Consumer<LoginViewmodel>(
        builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  onChanged: provider.updateEmail,
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                const SizedBox(height: 16.0), // Provide some vertical spacing
                TextField(
                  onChanged: provider.updatePassword,
                  controller: passwordController,
                  obscureText: true, // Use secure text for password.
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                ),
                const SizedBox(height: 30.0), // Provide some vertical spacing

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: const Text('로그인'),
                      onPressed: () async {
                        final result = await provider.signIn(
                            emailController.text, passwordController.text);
                        if (kDebugMode) {
                          print('로그인 결과: $result');
                        }
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
                      },
                    ),
                    const SizedBox(width: 16.0),
                    ElevatedButton(
                      child: const Text('로그아웃'),
                      onPressed: () async {
                        await provider.signOut();
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