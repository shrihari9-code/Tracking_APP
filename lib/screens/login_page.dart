import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'registration_page.dart';
import 'forgot_password.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

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

  Future<String> getUserTypeFromFirestore(String userId) async {
    // Implement your logic to fetch the user type from Firestore or any other data source
    // ...

    // For example:
    // You can use the 'userId' parameter to query the Firestore collection and retrieve the user type
    // DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    // String userType = snapshot.data()['userType'];

    // Replace the return statement with the actual logic to fetch and return the user type
    return ''; // Replace '' with the actual user type retrieved from Firestore
  }

  void _handleLogin() async {
    // Handle the login button press
    String email = _emailController.text;
    String password = _passwordController.text;

    // Validate the input
    if (email.isEmpty || password.isEmpty) {
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

    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        String userType = await getUserTypeFromFirestore(user.uid);

        if (userType == 'Parent' || userType == 'Guardian') {
          Navigator.pushReplacementNamed(context, '/parent');
        } else if (userType == 'Teacher') {
          Navigator.pushReplacementNamed(context, '/teacher');
        } else {
          print('Invalid user type: $userType');
        }
      }
    } catch (e) {
      print('Login failed: $e');
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Login failed. Please try again.'),
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
    }
  }

  void _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final UserCredential userCredential = await _auth.signInWithCredential(credential);

        // Handle the successful sign-in with Google
        // You can access the user's information using `userCredential.user`
      }
    } catch (e) {
      print('Sign in with Google failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
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
                onPressed: _handleLogin,
              ),
              SizedBox(height: 16),
              TextButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                ),
                onPressed: _signInWithGoogle,
                icon: Image.asset(
                  'assets/google_logo.png',
                  height: 24,
                ),
                label: Text(
                  'Sign in with Google',
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
            ],
          ),
        ),
      ),
    );
  }
}
