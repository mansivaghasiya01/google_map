import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MultipleMarkerOnTap extends StatefulWidget {
  const MultipleMarkerOnTap({Key? key}) : super(key: key);

  @override
  State<MultipleMarkerOnTap> createState() => _MultipleMarkerOnTapState();
}

class _MultipleMarkerOnTapState extends State<MultipleMarkerOnTap> {
  final Completer<GoogleMapController> _controller = Completer();

  List<Marker> markers = [];
  int id = 1;
  final Set<Polyline> _polylines = <Polyline>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onTap: (LatLng latLng) {
          Marker newMarker = Marker(
            markerId: MarkerId("$id"),
            position: LatLng(latLng.latitude, latLng.longitude),
            infoWindow: const InfoWindow(title: "New Place"),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          );
          markers.add(newMarker);
          id = id + 1;
          setState(() {});
        },
        initialCameraPosition: const CameraPosition(
            target: LatLng(21.2349961, 72.8355502), zoom: 15),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: markers.map((e) => e).toSet(),
        polylines: _polylines,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.directions),
      ),
    );
  }
}
