import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeoLocation extends StatefulWidget {
  const GeoLocation({super.key});

  @override
  State<GeoLocation> createState() => _GeoLocationState();
}

LatLng _mapCenter = const LatLng(23.7216771, 90.4165835);
GoogleMapController? _googleMapController;
final Set<Marker> _markers = {};
final Set<Polyline> _polylines = {};
final List<LatLng> _polylinePoints = [];

class _GeoLocationState extends State<GeoLocation> {
  Timer? _timer;

  Future<void> checkpermission() async {
    final permission = await Geolocator.checkPermission();

    log(permission.toString());
  }

  Future<void> requestpermission() async {
    final permission = await Geolocator.requestPermission();

    log(permission.toString());
  }

  Future<void> userLocation() async {
    final pos = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );
    LatLng currentPosition = LatLng(pos.latitude, pos.longitude);
    _polylinePoints.add(currentPosition);

    setState(() {
      _mapCenter = currentPosition;
      _markers.clear();
      _markers.add(
        Marker(
          markerId: const MarkerId('1'),

          position: _mapCenter,

          infoWindow: InfoWindow(
            title: 'My Current Location',

            snippet: '${pos.latitude}, ${pos.longitude}',
          ),
        ),
      );
      _polylines.clear();
      _polylines.add(
        Polyline(
          polylineId: const PolylineId('route'),
          points: _polylinePoints,
          visible: true,
          color: Colors.blue,
          width: 5,
          endCap: Cap.roundCap,
          startCap: Cap.squareCap,
          jointType: JointType.round,
        ),
      );
    });
    _googleMapController?.animateCamera(
      CameraUpdate.newLatLngZoom(_mapCenter, 16),
    );
  }

  @override
  void initState() {
    super.initState();
    checkpermission();
    requestpermission();
    userLocation();
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      userLocation();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Real-Time Location Tracker',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),

      body: GoogleMap(
        onMapCreated: (c) {
          _googleMapController = c;
        },
        initialCameraPosition: CameraPosition(target: _mapCenter, zoom: 12),
        markers: _markers,
        polylines: _polylines,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: true,
        trafficEnabled: true,

      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
