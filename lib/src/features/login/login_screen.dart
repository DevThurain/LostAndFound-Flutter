import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:lost_and_found/src/core/constants/app_color.dart';
import 'package:lost_and_found/src/core/constants/app_dimen.dart';
import 'package:lost_and_found/src/widgets/BasedText.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "login_screen";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IntroTitles(
              title: "Welcome Back!",
              subtitle: "Please sign in to your account",
            ),
            SizedBox(height: AppDimen.MARGIN_XXLARGE),
            TextFieldSection(),
            SizedBox(height: AppDimen.MARGIN_LARGE),
            ButtonSection()
          ],
        ),
      ),
    );
  }
}

class ButtonSection extends StatelessWidget {
  const ButtonSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimen.MARGIN_MEDIUM_2),
      child: Column(
        children: [
          SizedBox(
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
                "Sign In",
                style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
              ),
              onPressed: () {},
            ),
          ),
          SizedBox(height: AppDimen.MARGIN_CARD_MEDIUM_2),
          SizedBox(
            height: 50.0,
            width: double.infinity,
            child: ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                backgroundColor: MaterialStateProperty.all(AppColor.white),
                side: MaterialStateProperty.all(BorderSide(color: AppColor.darkGrey)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDimen.MARGIN_MEDIUM_2))),
              ),
              child: Row(
                children: [
                  Image(
                    image: AssetImage(
                      'assets/images/ic_google.png',
                    ),
                    width: AppDimen.MARGIN_XLARGE,
                  ),
                  Expanded(
                      child: BasedText(
                    text: 'Sign in with google',
                    textAlign: TextAlign.center,
                    fontColor: AppColor.darkGrey,
                    fontWeight: FontWeight.bold,
                  ))
                ],
              ),
              onPressed: () {},
            ),
          ),
          SizedBox(height: AppDimen.MARGIN_CARD_MEDIUM_2),
          Text.rich(
            TextSpan(children: [
              TextSpan(
                text: "Don\'t have an account?",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: AppColor.black,
                  fontSize: AppDimen.TEXT_REGULAR,
                ),
              ),
              WidgetSpan(child: SizedBox(width: AppDimen.MARGIN_MEDIUM,)),
              TextSpan(
                text: "Register",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: AppColor.violet,
                  fontSize: AppDimen.TEXT_REGULAR,
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}

class TextFieldSection extends StatefulWidget {
  TextFieldSection({
    Key? key,
  }) : super(key: key);

  @override
  State<TextFieldSection> createState() => _TextFieldSectionState();
}

class _TextFieldSectionState extends State<TextFieldSection> {
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimen.MARGIN_MEDIUM_2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            textInputAction: TextInputAction.next,
            style: TextStyle(fontFamily: 'Poppins'),
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppDimen.MARGIN_MEDIUM_2),
                    borderSide: BorderSide.none),
                filled: true,
                fillColor: AppColor.lightWhite,
                hintText: "Email"),
          ),
          SizedBox(height: AppDimen.MARGIN_MEDIUM_2),
          TextField(
            textInputAction: TextInputAction.done,
            obscureText: hidePassword,
            style: TextStyle(fontFamily: 'Poppins'),
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppDimen.MARGIN_MEDIUM_2),
                    borderSide: BorderSide.none),
                filled: true,
                fillColor: AppColor.lightWhite,
                suffixIcon: IconButton(
                  icon: hidePassword ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                  splashRadius: 1,
                  onPressed: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                ),
                hintText: "Password"),
          ),
          SizedBox(height: AppDimen.MARGIN_MEDIUM_2),
          Text(
            'Forget Password?',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: AppDimen.TEXT_REGULAR,
              color: AppColor.darkGrey,
            ),
          ),
        ],
      ),
    );
  }
}

class IntroTitles extends StatelessWidget {
  final String title;
  final String subtitle;

  IntroTitles({this.title = "", this.subtitle = ""});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
                color: AppColor.black,
                fontFamily: 'Poppins',
                fontSize: AppDimen.TEXT_REGULAR_2X,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: AppDimen.MARGIN_MEDIUM),
          Text(
            subtitle,
            style: TextStyle(
              color: AppColor.darkGrey,
              fontFamily: 'Poppins',
              fontSize: AppDimen.TEXT_REGULAR,
            ),
          ),
        ],
      ),
    );
  }
}
