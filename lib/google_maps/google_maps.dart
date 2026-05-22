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
        body: GoogleMap(
          mapType: MapType.normal,
          zoomControlsEnabled: true,
          zoomGesturesEnabled: false,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          trafficEnabled: true,
          initialCameraPosition:
          CameraPosition(
              zoom: 16,
              target: LatLng(23.86173302501156, 90.34820297765826)),
          onMapCreated: (GoogleMapController controller){
            _googleMapController = controller;

          },
          onTap: (LatLng latLng){
            print(latLng);
          },
          markers: <Marker>{
            Marker(
                markerId: MarkerId('home'),
                position: LatLng(23.857493943637614, 90.35158026963472),
                onTap: (){

                },
                visible: true,
                infoWindow: InfoWindow(title: 'Home',onTap: (){})

            ),
            Marker(
                markerId: MarkerId('office'),
                position: LatLng(23.873514276921856, 90.35922892391682),
                onTap: (){

                },
                visible: true,
                infoWindow: InfoWindow(title: 'Office',onTap: (){}),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueGreen
                )

            ),
            Marker(
                markerId: MarkerId('club'),
                position: LatLng(23.857193141012246, 90.34465245902538),
                onTap: (){

                },
                visible: true,
                infoWindow: InfoWindow(title: 'Clube',onTap: (){}),

                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueGreen
                )


            ),
          },

          polylines: {
            Polyline(
              polylineId: PolylineId('home-to-office'),
              points: [
                LatLng(23.857493943637614, 90.35158026963472),
                LatLng(23.873514276921856, 90.35922892391682),

              ],
              visible: true,
              color: Colors.green,
              endCap: Cap.roundCap,
              startCap: Cap.squareCap,
              jointType: JointType.round,
            ),
            Polyline(
              polylineId: PolylineId('office-to-clube'),
              points: [
                LatLng(23.857493943637614, 90.35158026963472),
                LatLng(23.857193141012246, 90.34465245902538),
                LatLng(23.857493943637614, 90.35158026963472),
                LatLng(23.873514276921856, 90.35922892391682),


              ],
              visible: true,
              color: Colors.red,
              endCap: Cap.roundCap,
              startCap: Cap.squareCap,
              jointType: JointType.round,
            ),
          },
          circles: {
            Circle(
                circleId: CircleId('zone-1'),
                center: LatLng(23.859585131166856, 90.34440368413925),
                radius: 100,
                strokeWidth: 3,
                strokeColor: Colors.orange,
                fillColor: Colors.yellowAccent
            )
          },
          polygons: {
            Polygon(
                polygonId: PolygonId('zone'),
                points: [
                  LatLng(23.857493943637614, 90.35158026963472),
                  LatLng(23.857193141012246, 90.34465245902538),

                ]
            )
          },
        )
    );
  }
}