import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ParentGuardianLoginPage extends StatelessWidget {
  final String name; // Name of the parent/guardian

  ParentGuardianLoginPage({required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parent/Guardian Login'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Perform logout action here
              // For example, navigate to the login screen
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
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
                LatLng busLocation = getUpdatedBusLocation();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BusLocationScreen(busLocation: busLocation)),
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
  final LatLng busLocation;

  BusLocationScreen({required this.busLocation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bus Location'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Perform logout action here
              // For example, navigate to the login screen
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Center(
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: busLocation,
            zoom: 15,
          ),
          markers: Set<Marker>.from([
            Marker(
              markerId: MarkerId('bus'),
              position: busLocation,
            ),
          ]),
        ),
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
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Perform logout action here
              // For example, navigate to the login screen
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Contact school information and options here'),
      ),
    );
  }
}

class ContactTeacherScreen extends StatefulWidget {
  @override
  _ContactTeacherScreenState createState() => _ContactTeacherScreenState();
}

class _ContactTeacherScreenState extends State<ContactTeacherScreen> {
  LatLng? _teacherLocation;

  @override
  void initState() {
    super.initState();
    _updateTeacherLocation();
  }

  void _updateTeacherLocation() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        // Update the teacher location
        _teacherLocation = getUpdatedTeacherLocation();
      });
    });
  }

  LatLng getUpdatedTeacherLocation() {
    // Replace this with your logic to retrieve the teacher location
    // You can use any method or API to get the updated teacher location
    // For now, I'll just simulate a random location
    double lat =15.8497 + Random().nextDouble() * 0.1;
    double lng = 74.4977+ Random().nextDouble() * 0.1;
    return LatLng(lat, lng);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Teacher'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Perform logout action here
              // For example, navigate to the login screen
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Teacher Location',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 16),
            if (_teacherLocation != null)
              Text('Latitude: ${_teacherLocation!.latitude}\nLongitude: ${_teacherLocation!.longitude}'),
          ],
        ),
      ),
    );
  }
}

LatLng getUpdatedBusLocation() {
  // Replace this with your logic to retrieve the bus location
  // You can use any method or API to get the updated bus location
  // For now, I'll just simulate a random location
  double lat = 15.8497 + Random().nextDouble() * 0.1;
  double lng = 74.4977 + Random().nextDouble() * 0.1;
  return LatLng(lat, lng);
}
