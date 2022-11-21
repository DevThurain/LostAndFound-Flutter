import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lost_and_found/src/core/constants/app_color.dart';
import 'package:lost_and_found/src/core/constants/app_dimen.dart';
import 'package:lost_and_found/src/features/global_widgets/poppin_text.dart';
import 'dart:io';
import 'dart:async';

class PickImageSection extends StatefulWidget {
  const PickImageSection({
    Key? key,
  }) : super(key: key);

  @override
  State<PickImageSection> createState() => _PickImageSectionState();
}

class _PickImageSectionState extends State<PickImageSection> {
  final ImagePicker _picker = ImagePicker();
  XFile? _itemImage;

  void _pickItemImage() async {
    _itemImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _itemImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        PoppinText(
          "Select Image",
          style: TextStyle(fontSize: AppDimen.TEXT_REGULAR_2X),
        ),
        SizedBox(height: AppDimen.MARGIN_MEDIUM_2),
        GestureDetector(
          onTap: () {
            _pickItemImage();
          },
          child: _itemImage == null
              ? Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColor.grey),
                      borderRadius: BorderRadius.all(
                        Radius.circular(AppDimen.MARGIN_MEDIUM_2),
                      )),
                  child: Center(
                    child: Icon(
                      Icons.photo,
                      size: AppDimen.MARGIN_XLARGE,
                    ),
                  ),
                )
              : ClipRRect(
                borderRadius: BorderRadius.circular(AppDimen.MARGIN_MEDIUM_2),
              child: Image.file(File(_itemImage?.path ?? ""),width: 150,height: 150,fit: BoxFit.cover,),
              )
        )
      ],
    );
  }
}
