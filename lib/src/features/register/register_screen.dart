import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lost_and_found/src/core/constants/app_color.dart';
import 'package:lost_and_found/src/core/constants/app_dimen.dart';
import 'package:lost_and_found/src/core/utils/utils.dart';
import 'package:lost_and_found/src/data/models/lost_and_found_model.dart';
import 'package:lost_and_found/src/data/models/lost_and_found_model_impl.dart';
import 'package:lost_and_found/src/data/vos/user_vo.dart';
import 'package:lost_and_found/src/features/based_screen/based_screen.dart';
import 'package:lost_and_found/src/features/home/home_screen.dart';
import 'package:lost_and_found/src/features/login/login_screen.dart';
import 'package:lost_and_found/src/features/register/bloc/register_bloc.dart';
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
    return BlocProvider<RegisterBloc>(
      create: (context) => RegisterBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            SafeArea(
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppDimen.MARGIN_MEDIUM),
                    child: BackButton(),
                  )),
            ),
            Center(
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
                    Builder(builder: (context) {
                      return TextFieldSection(
                        onNameChanged: (text) {
                          name = text;
                        },
                        onDone: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (name.isNotEmpty &&
                              email.isNotEmpty &&
                              phone.isNotEmpty &&
                              password.isNotEmpty) {
                            UserVO user = UserVO(name, email, password, phone, "", "", "");
                            context.read<RegisterBloc>().add(EventOnRegister(userVO: user));
                          }
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
                      );
                    }),
                    SizedBox(height: AppDimen.MARGIN_XXLARGE),
                    Builder(builder: (context) {
                      return BlocListener<RegisterBloc, RegisterState>(
                        bloc: BlocProvider.of<RegisterBloc>(context),
                        listener: (context, state) {
                          if (state.isLoading) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("please wait ..."),
                                backgroundColor: AppColor.violet));
                          }

                          if (state.appError != null) {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(state.appError?.errorMessage ?? ""),
                                backgroundColor: Colors.redAccent));
                          }

                          if (state.isSuccess) {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("success"), backgroundColor: AppColor.violet));

                            Navigator.pushNamedAndRemoveUntil(
                                context, BasedScreen.routeName, (route) => false);
                          }
                        },
                        child: Builder(builder: (context) {
                          return ButtonSection(
                            onRegister: () async {
                              FocusManager.instance.primaryFocus?.unfocus();
                              if (name.isNotEmpty &&
                                  email.isNotEmpty &&
                                  phone.isNotEmpty &&
                                  password.isNotEmpty) {
                                UserVO user = UserVO(name, email, password, phone, "", "", "");
                                context.read<RegisterBloc>().add(EventOnRegister(userVO: user));
                              }
                            },
                          );
                        }),
                      );
                    })
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.chevron_left),
      padding: EdgeInsets.zero,
      splashRadius: AppDimen.MARGIN_MEDIUM_3,
      onPressed: () {
        Navigator.pop(context);
      },
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
          FadeInDown(
            from: 30,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text.rich(
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
              ),
            ),
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
  final Function onDone;
  const TextFieldSection({
    required this.onNameChanged,
    required this.onEmailChanged,
    required this.onPhoneChanged,
    required this.onPasswordChanged,
    required this.onDone,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDimen.MARGIN_MEDIUM_2),
          child: Column(
            children: [
              FilledTextField(
                  textInputAction: TextInputAction.next,
                  fontFamily: 'Poppins',
                  filledColor: AppColor.lightWhite,
                  hintText: 'Full Name',
                  enable: !state.isLoading,
                  onImeAction: () {},
                  onChanged: (text) {
                    onNameChanged(text);
                  }),
              SizedBox(height: AppDimen.MARGIN_MEDIUM_2),
              FilledTextField(
                  textInputAction: TextInputAction.next,
                  fontFamily: 'Poppins',
                  filledColor: AppColor.lightWhite,
                  hintText: 'Email Address',
                  enable: !state.isLoading,
                  onImeAction: () {},
                  onChanged: (text) {
                    onEmailChanged(text);
                  }),
              SizedBox(height: AppDimen.MARGIN_MEDIUM_2),
              FilledTextField(
                  textInputAction: TextInputAction.next,
                  fontFamily: 'Poppins',
                  filledColor: AppColor.lightWhite,
                  hintText: 'Phone Number',
                  enable: !state.isLoading,
                  onImeAction: () {},
                  onChanged: (text) {
                    onPhoneChanged(text);
                  }),
              SizedBox(height: AppDimen.MARGIN_MEDIUM_2),
              FilledTextField(
                  textInputAction: TextInputAction.done,
                  fontFamily: 'Poppins',
                  filledColor: AppColor.lightWhite,
                  hintText: 'Password',
                  enable: !state.isLoading,
                  onImeAction: () {
                    onDone();
                  },
                  onChanged: (text) {
                    onPasswordChanged(text);
                  }),
            ],
          ),
        );
      },
    );
  }
}
