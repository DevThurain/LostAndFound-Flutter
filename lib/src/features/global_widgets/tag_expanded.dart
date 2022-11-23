import 'package:flutter/material.dart';
import 'package:lost_and_found/src/core/constants/app_color.dart';
import 'package:lost_and_found/src/core/constants/app_dimen.dart';
import 'package:lost_and_found/src/data/vos/tag_vo.dart';
import 'package:lost_and_found/src/features/global_widgets/poppin_text.dart';

class TagExpanded extends StatelessWidget {
  final TagVO tag;
  final Function(TagVO) onTapTag;
  const TagExpanded({
    Key? key,
    required this.tag,
    required this.onTapTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: AppDimen.MARGIN_MEDIUM_2),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppDimen.MARGIN_MEDIUM_2),
        onTap: () {
          onTapTag(tag);
        },
        child: Ink(
          padding: EdgeInsets.symmetric(
              horizontal: AppDimen.MARGIN_MEDIUM_3, vertical: AppDimen.MARGIN_MEDIUM),
          decoration: BoxDecoration(
              color: tag.selected ? AppColor.violet : AppColor.white,
              border: Border.all(color: tag.selected ? AppColor.violet : AppColor.grey),
              borderRadius: BorderRadius.circular(AppDimen.MARGIN_MEDIUM_2)),
          child: Center(
            child: PoppinText(
              tag.name,
              style: TextStyle(
                color: tag.selected ? AppColor.white : AppColor.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
