import 'package:firebase_core/firebase_core.dart';
import 'package:nado_giza/repository/firebase_login_repository.dart';
import 'package:nado_giza/view/home_view.dart';
import 'package:nado_giza/view/signup_view.dart';
import 'package:nado_giza/viewModel/news_data_viewmodel.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:nado_giza/view/login_view.dart';
import 'package:nado_giza/viewModel/login_viewmodel.dart';
import 'package:provider/provider.dart';

void main() async {
  // firebase 초기화
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseLoginRepository.instance();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginViewmodel>(
          create: (_) => LoginViewmodel(),
        ),
        ChangeNotifierProvider<NewsViewModel>(
          create: (_) => NewsViewModel(),
        ),
      ],
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '나도 기자',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginView(),
      initialRoute: '/',
      routes: {
        '/home': (context) => const HomeView(),
        '/signup': (context) => const SignUpView(),
      },
    );
  }
}
