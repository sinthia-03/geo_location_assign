import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMaps extends StatefulWidget {
  const GoogleMaps({super.key});

  @override
  State<GoogleMaps> createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  late final GoogleMapController _googleMapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Google Maps')),
      body: GoogleMap(
        mapType: MapType.normal,
        zoomControlsEnabled: true,
        zoomGesturesEnabled: false,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        trafficEnabled: true,
        initialCameraPosition: const CameraPosition(
          zoom: 16,
          target: LatLng(23.86173302501156, 90.34820297765826),
        ),
        onMapCreated: (GoogleMapController controller) {
          _googleMapController = controller;
        },
        onTap: (LatLng latLng) {
          print(latLng);
        },
        markers: <Marker>{
          Marker(
            markerId: const MarkerId('home'),
            position: const LatLng(23.857493943637614, 90.35158026963472),
            onTap: () {},
            visible: true,
            infoWindow: const InfoWindow(title: 'Home'),
          ),
          Marker(
            markerId: const MarkerId('office'),
            position: const LatLng(23.873514276921856, 90.35922892391682),
            onTap: () {},
            visible: true,
            infoWindow: const InfoWindow(title: 'Office'),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueGreen,
            ),
          ),
          Marker(
            markerId: const MarkerId('club'),
            position: const LatLng(23.857193141012246, 90.34465245902538),
            onTap: () {},
            visible: true,
            infoWindow: const InfoWindow(title: 'Club'),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueBlue,
            ),
          ),
        },
        polylines: {
          Polyline(
            polylineId: const PolylineId('home-to-office'),
            points: const [
              LatLng(23.857493943637614, 90.35158026963472),
              LatLng(23.873514276921856, 90.35922892391682),
            ],
            visible: true,
            color: Colors.green,
            width: 5,
            endCap: Cap.roundCap,
            startCap: Cap.squareCap,
            jointType: JointType.round,
          ),
          Polyline(
            polylineId: const PolylineId('office-to-club'),
            points: const [
              LatLng(23.857493943637614, 90.35158026963472),
              LatLng(23.857193141012246, 90.34465245902538),
              LatLng(23.873514276921856, 90.35922892391682),
            ],
            visible: true,
            color: Colors.red,
            width: 5,
            endCap: Cap.roundCap,
            startCap: Cap.squareCap,
            jointType: JointType.round,
          ),
        },

        circles: {
          Circle(
            circleId: const CircleId('zone-1'),
            center: const LatLng(23.859585131166856, 90.34440368413925),
            radius: 100,
            strokeWidth: 3,
            strokeColor: Colors.orange,
            fillColor: Colors.yellowAccent,
          ),
        },
        polygons: {
          Polygon(
            polygonId: const PolygonId('zone'),
            points: const [
              LatLng(23.857493943637614, 90.35158026963472),
              LatLng(23.857193141012246, 90.34465245902538),
            ],
          ),
        },
      ),
    );
  }
}
