import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TeacherLoginPage extends StatefulWidget {
  @override
  _TeacherLoginPageState createState() => _TeacherLoginPageState();
}

class _TeacherLoginPageState extends State<TeacherLoginPage> {
  final TextEditingController _startDestinationController = TextEditingController();
  final TextEditingController _endDestinationController = TextEditingController();
  GoogleMapController? _mapController;
  LatLng? _busLocation;
  Marker? _busMarker;

  @override
  void dispose() {
    _startDestinationController.dispose();
    _endDestinationController.dispose();
    super.dispose();
  }

  void _turnOnLocation() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Turn on Location'),
          content: Text('Please enable location services to track the bus.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Dismiss the dialog
              },
              child: Text('No Thanks'),
            ),
            TextButton(
              onPressed: () {
                // Enable location services
                // Start retrieving the bus location
                Navigator.pop(context); // Dismiss the dialog
              },
              child: Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  void _updateBusLocation() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      // Retrieve the bus location (you can replace this with your own logic)
      LatLng newBusLocation = getUpdatedBusLocation();

      setState(() {
        // Update the bus marker on the map
        _busLocation = newBusLocation;
        _busMarker = Marker(
          markerId: MarkerId('bus'),
          position: _busLocation!,
        );
      });
    });
  }

  LatLng getUpdatedBusLocation() {
    // Replace this with your logic to retrieve the bus location
    // You can use any method or API to get the updated bus location
    // For now, I'll just simulate a random location
    double lat = 37.7749 + Random().nextDouble() * 0.1;
    double lng = -122.4194 + Random().nextDouble() * 0.1;
    return LatLng(lat, lng);
  }

  @override
  void initState() {
    super.initState();
    _updateBusLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teacher Login'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _startDestinationController,
              decoration: InputDecoration(
                labelText: 'Start Destination',
              ),
            ),
            TextField(
              controller: _endDestinationController,
              decoration: InputDecoration(
                labelText: 'End Destination',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _turnOnLocation,
              child: Text('Turn on Location'),
            ),
            Expanded(
              child: GoogleMap(
                onMapCreated: (controller) {
                  _mapController = controller;
                },
                initialCameraPosition: CameraPosition(
                  target: LatLng(37.7749, -122.4194),
                  zoom: 12,
                ),
                markers: _busMarker != null ? Set<Marker>.from([_busMarker!]) : Set<Marker>(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
