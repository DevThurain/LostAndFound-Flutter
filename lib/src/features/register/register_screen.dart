import 'package:flutter/material.dart';
import 'package:lost_and_found/src/core/constants/app_color.dart';
import 'package:lost_and_found/src/core/constants/app_dimen.dart';
import 'package:lost_and_found/src/core/utils/utils.dart';
import 'package:lost_and_found/src/data/models/lost_and_found_model_impl.dart';
import 'package:lost_and_found/src/data/vos/user_vo.dart';
import 'package:lost_and_found/src/features/based_screen/based_screen.dart';
import 'package:lost_and_found/src/widgets/FilledTextField.dart';
import 'package:lost_and_found/src/widgets/IntroTitles.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = "/register_screen";
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String name = "";
  String email = "";
  String phone = "";
  String password = "";
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
              TextFieldSection(
                onNameChanged: (text) {
                  name = text;
                },
                onEmailChanged: (text) {
                  email = text;
                },
                onPhoneChanged: (text) {
                  phone = text;
                },
                onPasswordChanged: (text) {
                  password = text;
                },
              ),
              SizedBox(height: AppDimen.MARGIN_XXLARGE),
              ButtonSection(
                onRegister: () async {
                  if (name.isNotEmpty &&
                      email.isNotEmpty &&
                      phone.isNotEmpty &&
                      password.isNotEmpty) {
                    UserVO user = UserVO(name, email, password, phone, "", "", "");
                    LostAndFoundModelImpl().registerUser(user).then((user) {
                      Navigator.pushNamed(context, BasedScreen.routeName);
                    }).onError((error, stackTrace) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(error.toString())));
                    });
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonSection extends StatelessWidget {
  final Function onRegister;
  const ButtonSection({
    Key? key,
    required this.onRegister,
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
              onPressed: () {
                onRegister();
              },
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
  final Function(String) onNameChanged;
  final Function(String) onEmailChanged;
  final Function(String) onPhoneChanged;
  final Function(String) onPasswordChanged;
  const TextFieldSection({
    required this.onNameChanged,
    required this.onEmailChanged,
    required this.onPhoneChanged,
    required this.onPasswordChanged,
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
              onChanged: (text) {
                onNameChanged(text);
              }),
          SizedBox(height: AppDimen.MARGIN_MEDIUM_2),
          FilledTextField(
              textInputAction: TextInputAction.next,
              fontFamily: 'Poppins',
              filledColor: AppColor.lightWhite,
              hintText: 'Email Address',
              onChanged: (text) {
                onEmailChanged(text);
              }),
          SizedBox(height: AppDimen.MARGIN_MEDIUM_2),
          FilledTextField(
              textInputAction: TextInputAction.next,
              fontFamily: 'Poppins',
              filledColor: AppColor.lightWhite,
              hintText: 'Phone Number',
              onChanged: (text) {
                onPhoneChanged(text);
              }),
          SizedBox(height: AppDimen.MARGIN_MEDIUM_2),
          FilledTextField(
              textInputAction: TextInputAction.next,
              fontFamily: 'Poppins',
              filledColor: AppColor.lightWhite,
              hintText: 'Password',
              onChanged: (text) {
                onPasswordChanged(text);
              }),
        ],
      ),
    );
  }
}
