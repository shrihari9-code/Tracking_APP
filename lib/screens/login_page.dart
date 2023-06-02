import 'package:flutter/material.dart';
import 'registration_page.dart'; // Import the registration page
import 'forgot_password.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _navigateToRegistrationPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegistrationPage()),
    );
  }
  
  void _navigateToForgotPasswordPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        // Add your background image and styling here
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _navigateToForgotPasswordPage,
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                child: Text('Login'),
                onPressed: () {
                  // Handle the login button press
                  String email = _emailController.text;
                  String password = _passwordController.text;
                  // Call the authentication API or validate the credentials
                },
              ),
              SizedBox(height: 16),
              TextButton.icon( 
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                ), 
                onPressed: () {
                  // Handle the sign up with Google button press
                },
                icon: Image.asset(
                  'assets/google_logo.png',
                  height: 24,
                ),
                label: Text(
                  'Sign up with Google',
                ),
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: _navigateToRegistrationPage,
                child: Text(
                  'New User? Register Here',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              // Add other widgets as needed
            ],
          ),
        ),
      ),
    );
  }
}
