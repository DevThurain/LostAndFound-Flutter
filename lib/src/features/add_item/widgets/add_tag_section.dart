import 'package:flutter/material.dart';
import 'package:lost_and_found/src/core/constants/app_constants.dart';
import 'package:lost_and_found/src/core/constants/app_dimen.dart';
import 'package:lost_and_found/src/data/vos/tag_vo.dart';
import 'package:lost_and_found/src/features/global_widgets/poppin_text.dart';
import 'package:lost_and_found/src/features/global_widgets/tag_normal.dart';

class AddItemTagSection extends StatefulWidget {
  final Function(List<String>) onTagListChanged;
  const AddItemTagSection({
    Key? key,
    required this.onTagListChanged,
  }) : super(key: key);

  @override
  State<AddItemTagSection> createState() => _AddItemTagSectionState();
}

class _AddItemTagSectionState extends State<AddItemTagSection> {
  List<String> selectedTagList = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimen.MARGIN_MEDIUM_2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          PoppinText('Select Tags'),
          SizedBox(height: AppDimen.MARGIN_MEDIUM_2),
          Wrap(
            spacing: AppDimen.MARGIN_MEDIUM,
            runSpacing: AppDimen.MARGIN_MEDIUM,
            children: AppConstants.tagList
                .map((tag) => TagNormal(
                    tag: TagVO(name: tag, selected: selectedTagList.contains(tag)),
                    onTapTag: (tappedTag) {
                      if (!selectedTagList.contains(tappedTag.name)) {
                        setState(() {
                          selectedTagList.add(tappedTag.name);
                        });
                      } else {
                        setState(() {
                          selectedTagList.remove(tappedTag.name);
                        });
                      }
                      widget.onTagListChanged(selectedTagList);
                    }))
                .toList(),
          )
        ],
      ),
    );
  }
}
