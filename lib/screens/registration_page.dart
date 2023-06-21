import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _selectedUserRole;

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
                value: _selectedUserRole,
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
                  DropdownMenuItem(
                    child: Text('Teacher'),
                    value: 'Teacher',
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedUserRole = value;
                  });
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                child: Text('Register'),
                onPressed: register,
              ),
              // Add other widgets as needed
            ],
          ),
        ),
      ),
    );
  }

  Future<void> register() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;
    String mobileNumber = _mobileNumberController.text;

    // Validate the input
    if (email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        mobileNumber.isEmpty ||
        _selectedUserRole == null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Validation Error'),
            content: Text('Please fill in all fields.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    if (password != confirmPassword) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Validation Error'),
            content: Text('Passwords do not match.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    try {
      // Create a user with email and password
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save additional user data to Firebase Firestore
      // Replace 'users' with your desired collection name
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        'mobileNumber': mobileNumber,
        'userRole': _selectedUserRole,
      });

      // Registration successful, navigate to login page
        showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Registered Successfully'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/login');
                },
              ),
            ],
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Registration failed.';

      if (e.code == 'email-already-in-use') {
        errorMessage = 'The email address is already in use.';
      } else if (e.code == 'weak-password') {
        errorMessage = 'The password is too weak.';
      }

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Registration Error'),
            content: Text(errorMessage),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }
}
