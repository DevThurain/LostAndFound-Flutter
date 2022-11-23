import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lost_and_found/src/core/constants/app_color.dart';
import 'package:lost_and_found/src/core/constants/app_dimen.dart';
import 'package:lost_and_found/src/data/vos/tag_vo.dart';
import 'package:lost_and_found/src/features/add_item/add_item_screen.dart';
import 'package:lost_and_found/src/features/global_widgets/poppin_text.dart';
import 'package:lost_and_found/src/features/global_widgets/tag_expanded.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "home_screen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  HomeTitleSection(),
                  SizedBox(height: AppDimen.MARGIN_MEDIUM),
                  HomeTagSection(),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimen.MARGIN_MEDIUM_2, vertical: AppDimen.MARGIN_MEDIUM_2),
            child: ElasticIn(
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, AddItemScreen.routeName);
                },
                backgroundColor: AppColor.violet,
                splashColor: AppColor.white,
                child: Icon(Icons.add),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class HomeTitleSection extends StatelessWidget {
  const HomeTitleSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppDimen.MARGIN_MEDIUM_2, vertical: AppDimen.MARGIN_SMALL),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PoppinText(
                'Lost & Found',
                style: TextStyle(
                    fontSize: AppDimen.TEXT_REGULAR_2X,
                    color: AppColor.violet,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                decoration: BoxDecoration(shape: BoxShape.circle, color: AppColor.lightWhite),
                child: Padding(
                  padding: const EdgeInsets.all(AppDimen.MARGIN_MEDIUM),
                  child: SvgPicture.asset(
                    'assets/images/svgs/ic_notification.svg',
                    color: AppColor.black30,
                    width: AppDimen.MARGIN_LARGE,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimen.MARGIN_MEDIUM_2),
          InkWell(
            borderRadius: BorderRadius.circular(AppDimen.MARGIN_MEDIUM_2),
            onTap: () {},
            child: Ink(
              padding: EdgeInsets.symmetric(
                  vertical: AppDimen.MARGIN_MEDIUM_2, horizontal: AppDimen.MARGIN_MEDIUM_2),
              decoration: BoxDecoration(
                  color: AppColor.lightWhite,
                  borderRadius: BorderRadius.circular(AppDimen.MARGIN_MEDIUM_2)),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: AppColor.black30,
                  ),
                  SizedBox(width: AppDimen.MARGIN_MEDIUM_2),
                  PoppinText(
                    'Search Item',
                    style: TextStyle(color: AppColor.grey),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeTagSection extends StatelessWidget {
  const HomeTagSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
          padding: EdgeInsets.only(right: AppDimen.MARGIN_MEDIUM_2),
          scrollDirection: Axis.horizontal,
          itemCount: 12,
          itemBuilder: (context, position) {
            return TagExpanded(
              tag: TagVO(name: "Wallet", selected: true),
              onTapTag: (tag) {},
            );
          }),
    );
  }
}

