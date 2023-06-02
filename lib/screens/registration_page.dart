import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
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
                  hintText: 'Email',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: 'Password',
                  filled: true,
                  fillColor: Colors.white,
                ),
                obscureText: true,
              ),
              SizedBox(height: 16),
              TextField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
                  filled: true,
                  fillColor: Colors.white,
                ),
                obscureText: true,
              ),
              SizedBox(height: 16),
              TextField(
                controller: _mobileNumberController,
                decoration: InputDecoration(
                  hintText: 'Mobile Number',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: null,
                decoration: InputDecoration(
                  hintText: 'Register as',
                  filled: true,
                  fillColor: Colors.white,
                ),
                items: [
                  DropdownMenuItem(
                    child: Text('Parent'),
                    value: 'Parent',
                  ),
                  DropdownMenuItem(
                    child: Text('Guardian'),
                    value: 'Guardian',
                  ),
                ],
                onChanged: (value) {
                  // Handle dropdown value change
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                child: Text('Register'),
                onPressed: () {
                  // Handle the register button press
                  String email = _emailController.text;
                  String password = _passwordController.text;
                  String confirmPassword = _confirmPasswordController.text;
                  String mobileNumber = _mobileNumberController.text;
                  // Validate the input and perform registration
                },
              ),
              // Add other widgets as needed
            ],
          ),
        ),
      ),
    );
  }
}

