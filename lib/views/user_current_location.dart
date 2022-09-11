import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetUserCurrentLocation extends StatefulWidget {
  const GetUserCurrentLocation({Key? key}) : super(key: key);

  @override
  State<GetUserCurrentLocation> createState() => _GetUserCurrentLocationState();
}

class _GetUserCurrentLocationState extends State<GetUserCurrentLocation> {
  final Completer<GoogleMapController> _controller = Completer();

  final CameraPosition _kGooglePlex =
      const CameraPosition(target: LatLng(21.2349961, 72.8355502), zoom: 14);

  final List<Marker> markers = const <Marker>[
    Marker(
      markerId: MarkerId("1"),
      position: LatLng(21.2349961, 72.8355502),
      infoWindow: InfoWindow(title: "The title of the Marker"),
    ),
  ];

  Future<Position> getUserCurrentLocationFunction() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      log("error" + error.toString());
    });

    return await Geolocator.getCurrentPosition();
  }

  loadData() {
    getUserCurrentLocationFunction().then(
      (value) async {
        log(value.latitude.toString() + " " + value.longitude.toString());

        markers.add(
          Marker(
            markerId: const MarkerId("2"),
            position: LatLng(value.latitude, value.longitude),
            infoWindow: const InfoWindow(title: "My currnet location"),
          ),
        );

        CameraPosition cameraPosition = CameraPosition(
          zoom: 14,
          target: LatLng(value.latitude, value.longitude),
        );

        GoogleMapController controller = await _controller.future;

        controller
            .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      },
    );
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        mapType: MapType.normal,
        markers: Set<Marker>.of(markers),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.directions),
      ),
    );
  }
}
