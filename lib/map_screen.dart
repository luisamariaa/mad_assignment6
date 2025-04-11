import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  List<LatLng> tappedPoints = [];
  Set<Marker> markers = {};
  Set<Polyline> polyline = {};

  void _onMapTapped(LatLng point) {
    setState(() {
      if (tappedPoints.length == 2) {
        tappedPoints.clear();
        markers.clear();
        polyline.clear();
      }

      tappedPoints.add(point);

      markers.add(
        Marker(
          markerId: MarkerId(point.toString()),
          position: point,
          infoWindow: InfoWindow(
            title: tappedPoints.length == 1 ? 'Starting Point' : 'End Point',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            tappedPoints.length == 1
                ? BitmapDescriptor.hueRed
                : BitmapDescriptor.hueOrange,
          ),
        ),
      );
      if (tappedPoints.length == 2) {
        polyline.add(
          Polyline(
            polylineId: PolylineId('route'),
            points: tappedPoints,
            color: Colors.lightGreen,
            width: 5,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Google Maps with Polyline'),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.amber[50],
      ),
      body: GoogleMap(
        onMapCreated: (controller) => mapController = controller,
        onTap: _onMapTapped,
        initialCameraPosition: CameraPosition(
          target: LatLng(15.975803, 120.570693),
          zoom: 10,
        ),
        markers: markers,
        polylines: polyline,
      ),
    );
  }
}
