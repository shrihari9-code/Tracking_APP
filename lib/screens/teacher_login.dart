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
  List<Marker> _stopMarkers = [];

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

  void _addStop() {
    if (_busLocation != null) {
      setState(() {
        // Add a new stop marker to the map
        Marker stopMarker = Marker(
          markerId: MarkerId('stop_${_stopMarkers.length}'),
          position: _busLocation!,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        );
        _stopMarkers.add(stopMarker);
      });
    }
  }

  LatLng getUpdatedBusLocation() {
    // Replace this with your logic to retrieve the bus location
    // You can use any method or API to get the updated bus location
    // For now, I'll just simulate a random location
    double lat = 15.835757  + Random().nextDouble() * 0.1;
    double lng = 74.490902 + Random().nextDouble() * 0.1;
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
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _addStop,
              child: Text('Add Stop'),
            ),
            Expanded(
              child: GoogleMap(
                onMapCreated: (controller) {
                  setState(() {
                    _mapController = controller;
                  });
                },
                initialCameraPosition: CameraPosition(
                  target: LatLng(15.835757, 74.490902),
                  zoom: 12,
                ),
                markers: Set<Marker>.from([_busMarker!, ..._stopMarkers]),
                myLocationEnabled: true, // Enable my location button on the map
              ),
            ),
          ],
        ),
      ),
    );
  }
}
