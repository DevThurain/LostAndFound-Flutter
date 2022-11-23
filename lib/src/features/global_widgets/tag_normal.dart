import 'package:flutter/material.dart';
import 'package:lost_and_found/src/core/constants/app_color.dart';
import 'package:lost_and_found/src/core/constants/app_dimen.dart';
import 'package:lost_and_found/src/data/vos/tag_vo.dart';
import 'package:lost_and_found/src/features/global_widgets/poppin_text.dart';

class TagNormal extends StatelessWidget {
  final TagVO tag;
  final Function(TagVO) onTapTag;
  const TagNormal({
    Key? key,
    required this.tag,
    required this.onTapTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppDimen.MARGIN_MEDIUM_3, vertical: AppDimen.MARGIN_MEDIUM),
          child: PoppinText(
            tag.name,
            style: TextStyle(
              color: tag.selected ? AppColor.white : AppColor.black,
            ),
          ),
        ),
        Positioned.fill(
            child: InkWell(
          borderRadius: BorderRadius.circular(AppDimen.MARGIN_MEDIUM_2),
          onTap: () {
            onTapTag(tag);
          },
          child: Ink(
            decoration: BoxDecoration(
                color: tag.selected ? AppColor.violet : AppColor.white,
                border: Border.all(color: tag.selected ? AppColor.violet : AppColor.grey),
                borderRadius: BorderRadius.circular(AppDimen.MARGIN_MEDIUM_2)),
          ),
        ))
      ],
    );
  }
}
