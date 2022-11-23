import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lost_and_found/src/core/constants/app_color.dart';
import 'package:lost_and_found/src/core/constants/app_constants.dart';
import 'package:lost_and_found/src/core/constants/app_dimen.dart';
import 'package:lost_and_found/src/data/models/lost_and_found_model.dart';
import 'package:lost_and_found/src/data/models/lost_and_found_model_impl.dart';
import 'package:lost_and_found/src/data/vos/item_vo.dart';
import 'package:lost_and_found/src/data/vos/tag_vo.dart';
import 'package:lost_and_found/src/features/add_item/bloc/add_item_bloc.dart';
import 'package:lost_and_found/src/features/add_item/widgets/add_tag_section.dart';
import 'package:lost_and_found/src/features/add_item/widgets/map_and_address_widget.dart';
import 'package:lost_and_found/src/features/add_item/widgets/pick_image_section.dart';
import 'package:lost_and_found/src/features/global_widgets/google_map_section.dart';
import 'package:lost_and_found/src/features/global_widgets/poppin_text.dart';
import 'package:lost_and_found/src/features/global_widgets/tag_expanded.dart';
import 'package:lost_and_found/src/features/global_widgets/tag_normal.dart';
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
  String _photoPath = "";
  String _itemName = "";
  String _itemDetail = "";
  String _itemContactInfo = "";
  double _lat = 0.0;
  double _lon = 0.0;
  List<String> _selectedTag = [];

  @override
  void initState() {
    super.initState();
  }

  bool _validateInput() {
    return _address.isNotEmpty &&
        _photoPath.isNotEmpty &&
        _itemName.isNotEmpty &&
        _itemDetail.isNotEmpty &&
        _itemContactInfo.isNotEmpty &&
        _lat != 0.0 &&
        _lon != 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BlocProvider<AddItemBloc>(
        create: (context) => AddItemBloc(),
        child: Scaffold(
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
                  AddItemTextFieldSection(
                    onItemNameChanged: (itemName) {
                      _itemName = itemName;
                    },
                    onItemDetailChanged: (itemDetail) {
                      _itemDetail = itemDetail;
                    },
                    onContactInfoChanged: (itemContactInfo) {
                      _itemContactInfo = itemContactInfo;
                    },
                  ),
                  SizedBox(height: AppDimen.MARGIN_MEDIUM_2),
                  AddItemTagSection(
                    onTagListChanged: (tagList) {
                      _selectedTag = tagList;
                    },
                  ),
                  SizedBox(height: AppDimen.MARGIN_MEDIUM_2),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppDimen.MARGIN_MEDIUM_2),
                    child: MapAndAddressWidget(onGetAddress: (address) {
                      _address = address;
                    }, onGetLocation: (location) {
                      _lat = location.latitude;
                      _lon = location.longitude;
                    }),
                  ),
                  SizedBox(height: AppDimen.MARGIN_MEDIUM),
                  Divider(thickness: 1),
                  SizedBox(height: AppDimen.MARGIN_MEDIUM_2),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppDimen.MARGIN_MEDIUM_2),
                      child: PickImageSection(
                        onPickImage: (imagePath) {
                          _photoPath = imagePath;
                        },
                      )),
                  SizedBox(height: AppDimen.MARGIN_LARGE),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppDimen.MARGIN_MEDIUM_2),
                    child: Builder(builder: (context) {
                      return BlocListener<AddItemBloc, AddItemState>(
                        listener: (context, state) {
                          if (state.isLoading) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("please wait ..."),
                                backgroundColor: AppColor.violet));
                          }

                          if (state.appError != null) {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(state.appError?.errorMessage ?? ""),
                                backgroundColor: Colors.redAccent));
                          }

                          if (state.isSuccess) {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("success"), backgroundColor: AppColor.violet));

                            Navigator.pop(context);
                          }
                        },
                        child: UploadButtonSection(
                          onUpload: () {
                            if (_validateInput()) {
                              ItemVO item = ItemVO(
                                  name: _itemName,
                                  description: _itemDetail,
                                  contactInfo: _itemContactInfo,
                                  lat: _lat,
                                  lon: _lon,
                                  photoPath: _photoPath,
                                  address: _address);
                              context.read<AddItemBloc>().add(EventOnAddItem(item));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  duration: Duration(milliseconds: 1000),
                                  content: Text("missing item info..."),
                                  backgroundColor: Colors.redAccent));
                            }
                          },
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: AppDimen.MARGIN_MEDIUM_2),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}


class UploadButtonSection extends StatelessWidget {
  final Function onUpload;
  const UploadButtonSection({
    required this.onUpload,
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
        onPressed: () {
          onUpload();
        },
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
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: AppDimen.TEXT_REGULAR_2X,
          ),
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
  final Function(String) onItemNameChanged;
  final Function(String) onItemDetailChanged;
  final Function(String) onContactInfoChanged;

  const AddItemTextFieldSection({
    required this.onItemNameChanged,
    required this.onItemDetailChanged,
    required this.onContactInfoChanged,
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
              onChanged: (text) {
                onItemNameChanged(text);
              }),
          SizedBox(height: AppDimen.MARGIN_MEDIUM_2),
          FilledTextField(
              textInputAction: TextInputAction.next,
              fontFamily: 'Poppins',
              filledColor: AppColor.lightWhite,
              hintText: 'Detail',
              maxLines: 5,
              onImeAction: () {},
              onChanged: (text) {
                onItemDetailChanged(text);
              }),
          SizedBox(height: AppDimen.MARGIN_MEDIUM_2),
          FilledTextField(
              textInputAction: TextInputAction.next,
              fontFamily: 'Poppins',
              filledColor: AppColor.lightWhite,
              hintText: 'Contact Info',
              onImeAction: () {},
              onChanged: (text) {
                onContactInfoChanged(text);
              }),
        ],
      ),
    );
  }
}
