import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lost_and_found/src/core/constants/app_color.dart';
import 'package:lost_and_found/src/core/constants/app_dimen.dart';
import 'package:lost_and_found/src/features/add_item/widgets/map_and_address_widget.dart';
import 'package:lost_and_found/src/features/add_item/widgets/pick_image_section.dart';
import 'package:lost_and_found/src/features/global_widgets/google_map_section.dart';
import 'package:lost_and_found/src/features/global_widgets/poppin_text.dart';
import 'package:lost_and_found/src/widgets/FilledTextField.dart';
import 'dart:async';

import 'package:permission_handler/permission_handler.dart';

class AddItemScreen extends StatefulWidget {
  static const routeName = "/add_item_screen";
  const AddItemScreen({Key? key}) : super(key: key);

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  String _address = "";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        backgroundColor: AppColor.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppDimen.MARGIN_MEDIUM),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppDimen.MARGIN_MEDIUM),
                  child: AddItemTitleSection(),
                ),
                SizedBox(height: AppDimen.MARGIN_MEDIUM_2),
                AddItemTextFieldSection(),
                SizedBox(height: AppDimen.MARGIN_MEDIUM_2),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppDimen.MARGIN_MEDIUM_2),
                  child:
                      MapAndAddressWidget(onGetAddress: (address) {}, onGetLocation: (location) {}),
                ),
                SizedBox(height: AppDimen.MARGIN_MEDIUM),
                Divider(thickness: 1),
                SizedBox(height: AppDimen.MARGIN_MEDIUM_2),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppDimen.MARGIN_MEDIUM_2),
                    child: PickImageSection()),
                SizedBox(height: AppDimen.MARGIN_LARGE),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppDimen.MARGIN_MEDIUM_2),
                  child: UploadButtonSection(),
                ),
                SizedBox(height: AppDimen.MARGIN_MEDIUM_2),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class UploadButtonSection extends StatelessWidget {
  const UploadButtonSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(AppColor.violet),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimen.MARGIN_MEDIUM_2))),
        ),
        child: Text(
          "Upload Post",
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
        ),
        onPressed: () {},
      ),
    );
  }
}

class AddItemTitleSection extends StatelessWidget {
  const AddItemTitleSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(Icons.chevron_left),
          padding: EdgeInsets.zero,
          splashRadius: AppDimen.MARGIN_MEDIUM_3,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        PoppinText(
          "Add Item",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: AppDimen.TEXT_REGULAR_3X),
        ),
        IconButton(
          icon: Icon(Icons.more_vert),
          color: Colors.white,
          padding: EdgeInsets.zero,
          splashRadius: AppDimen.MARGIN_MEDIUM_3,
          onPressed: null,
        ),
      ],
    );
  }
}

class AddItemTextFieldSection extends StatelessWidget {
  const AddItemTextFieldSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimen.MARGIN_MEDIUM_2),
      child: Column(
        children: [
          FilledTextField(
              textInputAction: TextInputAction.next,
              fontFamily: 'Poppins',
              filledColor: AppColor.lightWhite,
              hintText: 'Item Name',
              onImeAction: () {},
              onChanged: (text) {}),
          SizedBox(height: AppDimen.MARGIN_MEDIUM_2),
          FilledTextField(
              textInputAction: TextInputAction.next,
              fontFamily: 'Poppins',
              filledColor: AppColor.lightWhite,
              hintText: 'Detail',
              maxLines: 5,
              onImeAction: () {},
              onChanged: (text) {}),
          SizedBox(height: AppDimen.MARGIN_MEDIUM_2),
          FilledTextField(
              textInputAction: TextInputAction.next,
              fontFamily: 'Poppins',
              filledColor: AppColor.lightWhite,
              hintText: 'Contact Info',
              onImeAction: () {},
              onChanged: (text) {}),
        ],
      ),
    );
  }
}
