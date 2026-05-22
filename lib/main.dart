import 'package:flutter/material.dart';
import 'package:geo_location_assig/geo_location/geo_location.dart';

void main() {
  runApp( Gps());
}

class Gps extends StatefulWidget {
  const Gps({super.key});

  @override
  State<Gps> createState() => _GpsState();
}

class _GpsState extends State<Gps> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:GeoLocation(),
    );
  }
}

