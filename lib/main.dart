import 'package:flutter/material.dart';
import 'screens/login_page.dart';
import 'screens/registration_page.dart';
import 'screens/forgot_password.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: LoginPage(),
      routes: {
        '/login': (context) => LoginPage(),
        '/registration': (context) => RegistrationPage(),
        '/forgot-password':(context) => ForgotPasswordPage(),
        '/home': (context) => const MyHomePage(title: 'Flutter Demo Home Page'),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    // Your home page code here
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const Center(
        child: Text('Welcome to the Home Page!'),
      ),
    );
  }
}
