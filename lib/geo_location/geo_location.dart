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

LatLng _mapCenter = const LatLng(23.86173302501156, 90.34820297765826);
GoogleMapController? _googleMapController;

final Set<Marker> _markers = {};

class _GeoLocationState extends State<GeoLocation> {

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
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );

    setState(() {
      _mapCenter = LatLng(pos.latitude, pos.longitude);

      _markers.clear();
      _markers.add(
        Marker(
          markerId: const MarkerId('1'),
          position: _mapCenter,
          infoWindow: const InfoWindow(title: 'My location'),
        ),
      );

      _googleMapController?.animateCamera(
        CameraUpdate.newLatLngZoom(_mapCenter, 15),
      );
    });
  }

  bool _isStreaming = false;
  StreamSubscription<Position>? _positionStream;

  void toggleStream() {
    if (_isStreaming) {
      _positionStream?.cancel();
      setState(() {
        _isStreaming = false;
      });
    } else {
      setState(() {
        _isStreaming = true;
      });
      _positionStream = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 5,
        ),
      ).listen((pos) {

        log(pos.toString());
        final posLatLng = LatLng(pos.latitude, pos.longitude);

        setState(() {
          _mapCenter = posLatLng;

          _markers.clear();
          _markers.add(
            Marker(
              markerId: const MarkerId('1'),
              position: _mapCenter,
              infoWindow: const InfoWindow(title: 'My location'),
            ),
          );
        });

        _googleMapController?.animateCamera(
          CameraUpdate.newLatLngZoom(_mapCenter, 15),
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkpermission();
    requestpermission();
    userLocation();
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geo location'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 500,
            child: GoogleMap(
              onMapCreated: (c) => _googleMapController = c,
              initialCameraPosition: CameraPosition(
                target: _mapCenter,
                zoom: 12,
              ),
              markers: _markers,
              myLocationEnabled: true,
              zoomControlsEnabled: false,
            ),
          ),

          ElevatedButton(
            onPressed: toggleStream,
            child: Text(_isStreaming ? 'Stop' : 'Stream'),
          )
        ],
      ),
    );
  }
}