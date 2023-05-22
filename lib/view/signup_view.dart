import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nado_giza/viewModel/login_viewmodel.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  SignUpViewState createState() => SignUpViewState();
}

class SignUpViewState extends State<SignUpView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원가입'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: '이메일',
              ),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: '비밀번호',
              ),
            ),
            TextField(
              controller: confirmController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: '비밀번호 확인',
              ),
            ),
            const SizedBox(height: 16.0), // Provide some vertical spacing
            ElevatedButton(
              child: const Text('회원가입'),
              onPressed: () async {
                String email = emailController.text;
                String password = passwordController.text;
                String confirm = confirmController.text;

                if (!isEmailValid(email)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('이메일 형식이 올바르지 않습니다.')),
                  );
                  return;
                }

                if (!isPasswordCompliant(password)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('비밀번호가 충분히 강력하지 않습니다.')),
                  );
                  return;
                }

                if (password != confirm) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('비밀번호가 일치하지 않습니다.')),
                  );
                  return;
                }

                // Use your LoginViewModel here
                final loginViewModel =
                    Provider.of<LoginViewmodel>(context, listen: false);
                String? resultText =
                    await loginViewModel.signUp(email, password);

                if (resultText == null) {
                  // Navigate to the next screen
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacementNamed(context, '/home');
                } else {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('회원가입에 실패했습니다. $resultText')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  bool isEmailValid(String email) {
    String emailPattern =
        r'^[a-zA-Z0-9.a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    return RegExp(emailPattern).hasMatch(email);
  }

  bool isPasswordCompliant(String password) {
    if (password.isEmpty) {
      return false;
    }

    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    bool hasDigits = password.contains(RegExp(r'[0-9]'));
    bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    bool hasSpecialCharacters =
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    num minLength = 8;
    bool hasMinLength = password.length > minLength;

    return hasDigits &
        hasUppercase &
        hasLowercase &
        hasSpecialCharacters &
        hasMinLength;
  }
}
