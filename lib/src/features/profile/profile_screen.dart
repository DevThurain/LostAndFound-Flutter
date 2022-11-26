import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lost_and_found/src/core/constants/app_color.dart';
import 'package:lost_and_found/src/core/constants/app_dimen.dart';
import 'package:lost_and_found/src/data/models/lost_and_found_model_impl.dart';
import 'package:lost_and_found/src/features/global_widgets/circular_border.dart';
import 'package:lost_and_found/src/features/global_widgets/poppin_text.dart';
import 'package:lost_and_found/src/features/login/login_screen.dart';
import 'package:lost_and_found/src/persistence/daos/user_dao.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Column(
          children: [
            Spacer(),
            ProfilePictureSection(),
            SizedBox(height: AppDimen.MARGIN_XLARGE),
            ProfileDetail(),
            Spacer(),
            ProfileLogOutSection(),
            SizedBox(height: AppDimen.MARGIN_MEDIUM_3),
          ],
        ),
      ),
    );
  }
}

class ProfileLogOutSection extends StatelessWidget {
  const ProfileLogOutSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Color.fromARGB(48, 255, 82, 82),
      borderRadius: BorderRadius.circular(AppDimen.MARGIN_MEDIUM_2),
      onTap: () {
        LostAndFoundModelImpl().logoutUser().then((value) {
          Navigator.popAndPushNamed(context, LoginScreen.routeName);
        });
      },
      child: Ink(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(AppDimen.MARGIN_MEDIUM_2)),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppDimen.MARGIN_MEDIUM_2, vertical: AppDimen.MARGIN_MEDIUM),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.logout,
                color: Colors.redAccent,
              ),
              SizedBox(width: AppDimen.MARGIN_MEDIUM),
              PoppinText(
                'Logout',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(color: Colors.redAccent),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileDetail extends StatelessWidget {
  const ProfileDetail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileTextRow(
          title: 'full name',
          text: UserDao().getUser(FirebaseAuth.instance.currentUser!.uid)?.fullName ?? "-",
          iconData: Icons.person_outline,
          borderColor: AppColor.violet,
        ),
        SizedBox(height: AppDimen.MARGIN_MEDIUM_2),
        ProfileTextRow(
          title: 'email',
          text: UserDao().getUser(FirebaseAuth.instance.currentUser!.uid)?.email ?? "-",
          iconData: Icons.email_outlined,
          borderColor: AppColor.grey,
        ),
        SizedBox(height: AppDimen.MARGIN_MEDIUM_2),
        ProfileTextRow(
          title: 'phone',
          text: UserDao().getUser(FirebaseAuth.instance.currentUser!.uid)?.phone ?? "-",
          iconData: Icons.phone_outlined,
          borderColor: AppColor.grey,
        ),
      ],
    );
  }
}

class ProfileTextRow extends StatelessWidget {
  final String title;
  final String text;
  final IconData iconData;
  final Color borderColor;
  const ProfileTextRow({
    required this.title,
    required this.text,
    required this.iconData,
    required this.borderColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: AppDimen.MARGIN_MEDIUM_2),
      padding: EdgeInsets.symmetric(
          horizontal: AppDimen.MARGIN_MEDIUM_2, vertical: AppDimen.MARGIN_MEDIUM_2),
      decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(AppDimen.MARGIN_MEDIUM_3)),
      child: Row(
        children: [
          Icon(
            iconData,
            color: AppColor.grey,
          ),
          SizedBox(width: AppDimen.MARGIN_MEDIUM_2),
          VerticalDivider(),
          SizedBox(width: AppDimen.MARGIN_MEDIUM_2),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PoppinText(
                title,
                style: TextStyle(fontSize: AppDimen.TEXT_SMALL, color: AppColor.grey),
              ),
              PoppinText(
                text,
                style: TextStyle(),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class VerticalDivider extends StatelessWidget {
  const VerticalDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 35,
      color: AppColor.darkGrey,
    );
  }
}

class ProfileTitleSection extends StatelessWidget {
  const ProfileTitleSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PoppinText(
      'Profile',
      style: TextStyle(fontSize: AppDimen.TEXT_REGULAR_2X, fontWeight: FontWeight.bold),
    );
  }
}

class ProfilePictureSection extends StatelessWidget {
  const ProfilePictureSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: Stack(
        children: [
          CircularBorder(
            width: 2,
            size: 75,
            color: AppColor.violet,
            icon: PoppinText(
             UserDao().getUser(FirebaseAuth.instance.currentUser!.uid)?.fullName.characters.first ?? '-',
              style: TextStyle(
                fontSize: AppDimen.TEXT_HEADING_1X,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: CircleAvatar(
              radius: AppDimen.MARGIN_MEDIUM_2,
              backgroundColor: AppColor.black30,
              child: Icon(
                Icons.camera,
                size: AppDimen.MARGIN_MEDIUM_3,
                color: AppColor.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
