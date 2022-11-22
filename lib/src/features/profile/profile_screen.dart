import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lost_and_found/src/core/constants/app_color.dart';
import 'package:lost_and_found/src/data/models/lost_and_found_model_impl.dart';
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
      body: Center(
        child: GestureDetector(
          onTap: () async {
            LostAndFoundModelImpl().logoutUser().then((value) {
             Navigator.popAndPushNamed(context, LoginScreen.routeName);
            });
          },
          child: PoppinText(
            "Logout",
            style: TextStyle(color: AppColor.violet),
          ),
        ),
      ),
    );
  }
}
