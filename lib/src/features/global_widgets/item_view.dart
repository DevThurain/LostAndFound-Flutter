import 'package:flutter/material.dart';
import 'package:lost_and_found/src/core/constants/app_color.dart';
import 'package:lost_and_found/src/core/constants/app_dimen.dart';
import 'package:lost_and_found/src/core/utils/my_date_utils.dart';
import 'package:lost_and_found/src/features/global_widgets/poppin_text.dart';

class ItemView extends StatelessWidget {
  const ItemView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: AppDimen.MARGIN_MEDIUM_2,
          left: AppDimen.MARGIN_MEDIUM_2,
          right: AppDimen.MARGIN_MEDIUM_2),
      child: Stack(
        children: [
          Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppDimen.MARGIN_MEDIUM_3),
                    topRight: Radius.circular(AppDimen.MARGIN_MEDIUM_3)),
                child: Image.network(
                  'https://images.unsplash.com/photo-1661961110218-35af7210f803?ixlib=rb-4.0.3&ixid=MnwxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=600&q=60',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                    vertical: AppDimen.MARGIN_MEDIUM_2, horizontal: AppDimen.MARGIN_MEDIUM_2),
                decoration: BoxDecoration(
                  color: AppColor.lightWhite,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(AppDimen.MARGIN_MEDIUM_3),
                      bottomRight: Radius.circular(AppDimen.MARGIN_MEDIUM_3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PoppinText(
                      'Wallet',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    SizedBox(height: AppDimen.MARGIN_MEDIUM_2),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: AppColor.violet,
                        ),
                        SizedBox(width: AppDimen.MARGIN_MEDIUM),
                        PoppinText(
                          'Near Icon Mart',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: AppDimen.MARGIN_MEDIUM,horizontal: AppDimen.MARGIN_MEDIUM),
              padding: EdgeInsets.symmetric(horizontal: AppDimen.MARGIN_MEDIUM,vertical: AppDimen.MARGIN_SMALL),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppDimen.MARGIN_MEDIUM_2)
              ),
              child: PoppinText(MyDateUtils.getReadableDate(context),style: TextStyle(
                fontSize: AppDimen.TEXT_XSMALL,
              ),),
            ),
          ),
        ],
      ),
    );
  }
}
