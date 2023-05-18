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
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                const SizedBox(height: 16.0), // Provide some vertical spacing
                TextField(
                  controller: passwordController,
                  obscureText: true, // Use secure text for password.
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                ),
                const SizedBox(height: 16.0), // Provide some vertical spacing

                Row(
                  children: [
                    ElevatedButton(
                      child: const Text('로그인'),
                      onPressed: () {
                        // TODO: Implement your login logic here
                      },
                    ),
                    ElevatedButton(
                      child: const Text('회원가입'),
                      onPressed: () {
                        if (kDebugMode) {
                          print("회원가입");
                        }
                        provider.signUp('', '');
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
