import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class GoogleMapSection extends StatefulWidget {
  final Function(LatLng) getLocation;
  final Function(String,String) getAddress;
  const GoogleMapSection({
    required this.getLocation,
    required this.getAddress,
    Key? key,
  }) : super(key: key);

  @override
  State<GoogleMapSection> createState() => _MapSectionState();
}

class _MapSectionState extends State<GoogleMapSection> {
  Completer<GoogleMapController> _controller = Completer();
  LatLng? _selectedPosition;
  CameraPosition? _kMyPosition;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState() {
    _handlePermissions();

    super.initState();
  }

  void _handlePermissions() async {
    if (await Permission.locationWhenInUse.request().isGranted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Location Permission Granted.")));

      
      await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((value) {
        setState(() {
          _selectedPosition = LatLng(value.latitude, value.longitude);
          _kMyPosition = CameraPosition(
            target: LatLng(value.latitude, value.longitude),
            zoom: 14.4746,
          );
          widget.getLocation(_selectedPosition!);
          _getAddressFromLatLng(_selectedPosition!);
        });
        _goToMyPosition();
      });
    }
  }

  Future<void> _goToMyPosition() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kMyPosition!));
  }

  Future<void> _getAddressFromLatLng(LatLng position) async {
    await placemarkFromCoordinates(position.latitude, position.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        var address =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
        widget.getAddress(place.street ?? "", place.subAdministrativeArea ?? "");
      });
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      compassEnabled: false,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
            gestureRecognizers: Set()
        ..add( Factory<PanGestureRecognizer>(() => PanGestureRecognizer())),
      markers: {Marker(markerId: MarkerId("0"), position: _selectedPosition ?? LatLng(0, 0))},
      mapType: MapType.terrain,
      initialCameraPosition: _kMyPosition ?? _kGooglePlex,
      onTap: (latLng) {
        setState(() {
          _selectedPosition = LatLng(latLng.latitude, latLng.longitude);
          widget.getLocation(_selectedPosition!);
          _getAddressFromLatLng(_selectedPosition!);
        });
      },
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }
}
