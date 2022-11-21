import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lost_and_found/src/core/constants/app_dimen.dart';
import 'package:lost_and_found/src/features/global_widgets/google_map_section.dart';
import 'package:lost_and_found/src/features/global_widgets/poppin_text.dart';

class MapAndAddressWidget extends StatefulWidget {
  final Function(String) onGetAddress;
  final Function(LatLng) onGetLocation;
  const MapAndAddressWidget({Key? key, required this.onGetAddress, required this.onGetLocation})
      : super(key: key);

  @override
  State<MapAndAddressWidget> createState() => _MapAndAddressWidgetState();
}

class _MapAndAddressWidgetState extends State<MapAndAddressWidget> {
  var _address = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppDimen.MARGIN_MEDIUM_2),
          child: Container(
            width: double.infinity,
            height: 300,
            child: GoogleMapSection(
              getAddress: (street, region) {
                if (street.contains("+")) {
                  _address = region.toString();
                } else {
                  _address = "$street, $region";
                }
                setState(() {
                  _address;
                });
                widget.onGetAddress(_address);

              },
              getLocation: (location) {
                widget.onGetLocation(location);
              },
            ),
          ),
        ),
        SizedBox(height: AppDimen.MARGIN_MEDIUM_2),
        PoppinText(
          "Found Location - $_address",
          style: TextStyle(fontSize: AppDimen.TEXT_REGULAR_2X),
        ),
      ],
    );
  }
}
