import 'package:flutter/material.dart';
import 'package:lost_and_found/src/core/constants/app_color.dart';
import 'package:lost_and_found/src/core/constants/app_dimen.dart';
import 'package:lost_and_found/src/core/utils/utils.dart';
import 'package:lost_and_found/src/widgets/FilledTextField.dart';
import 'package:lost_and_found/src/widgets/IntroTitles.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = "/register_screen";
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: Utils.darkIconStatusBar(),
      body: Center(
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IntroTitles(
                title: "Create new account",
                subtitle: "Please fill in the form to continue",
              ),
              SizedBox(height: AppDimen.MARGIN_XXLARGE),
              TextFieldSection(),
              SizedBox(height: AppDimen.MARGIN_XXLARGE),
              ButtonSection()
            ],
          ),
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
                "Register",
                style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
              ),
              onPressed: () {},
            ),
          ),
          SizedBox(height: AppDimen.MARGIN_MEDIUM_2),
          Text.rich(
            TextSpan(children: [
              TextSpan(
                text: "Already have an account?",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: AppColor.black,
                  fontSize: AppDimen.TEXT_REGULAR,
                ),
              ),
              WidgetSpan(
                  child: SizedBox(
                width: AppDimen.MARGIN_MEDIUM,
              )),
              TextSpan(
                text: "Sign In",
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

class TextFieldSection extends StatelessWidget {
  const TextFieldSection({
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
              hintText: 'Full Name',
              onChanged: (text) {}),
          SizedBox(height: AppDimen.MARGIN_MEDIUM_2),
          FilledTextField(
              textInputAction: TextInputAction.next,
              fontFamily: 'Poppins',
              filledColor: AppColor.lightWhite,
              hintText: 'Email Address',
              onChanged: (text) {}),
          SizedBox(height: AppDimen.MARGIN_MEDIUM_2),
          FilledTextField(
              textInputAction: TextInputAction.next,
              fontFamily: 'Poppins',
              filledColor: AppColor.lightWhite,
              hintText: 'Phone Number',
              onChanged: (text) {}),
          SizedBox(height: AppDimen.MARGIN_MEDIUM_2),
          FilledTextField(
              textInputAction: TextInputAction.next,
              fontFamily: 'Poppins',
              filledColor: AppColor.lightWhite,
              hintText: 'Password',
              onChanged: (text) {}),
        ],
      ),
    );
  }
}
