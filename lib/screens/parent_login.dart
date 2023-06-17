import 'package:flutter/material.dart';

class ParentGuardianLoginPage extends StatelessWidget {
  final String name; // Name of the parent/guardian

  ParentGuardianLoginPage({required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parent/Guardian Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome, $name!',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle "Know the bus location" button press
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BusLocationScreen()),
                );
              },
              child: Text('Know the Bus Location'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle "Contact School" button press
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactSchoolScreen()),
                );
              },
              child: Text('Contact School'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle "Contact Teacher" button press
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactTeacherScreen()),
                );
              },
              child: Text('Contact Teacher'),
            ),
          ],
        ),
      ),
    );
  }
}

class BusLocationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bus Location'),
      ),
      body: Center(
        child: Text('Display the bus location here'),
      ),
    );
  }
}

class ContactSchoolScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact School'),
      ),
      body: Center(
        child: Text('Contact school information and options here'),
      ),
    );
  }
}

class ContactTeacherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Teacher'),
      ),
      body: Center(
        child: Text('Contact teacher information and options here'),
      ),
    );
  }
}
