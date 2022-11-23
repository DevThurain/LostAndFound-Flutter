import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lost_and_found/src/core/constants/app_color.dart';
import 'package:lost_and_found/src/core/constants/app_dimen.dart';
import 'package:lost_and_found/src/core/utils/utils.dart';
import 'package:lost_and_found/src/features/based_screen/bloc/bottom_navigation_bloc.dart';
import 'package:lost_and_found/src/features/home/home_screen.dart';
import 'package:lost_and_found/src/features/post/post_screen.dart';
import 'package:lost_and_found/src/features/profile/profile_screen.dart';

class BasedScreen extends StatefulWidget {
  static const routeName = "/based_screen";
  const BasedScreen({Key? key}) : super(key: key);

  @override
  State<BasedScreen> createState() => _BasedScreenState();
}

class _BasedScreenState extends State<BasedScreen> {
  var _screenList = [HomeScreen(), PostScreen(), ProfileScreen()];
  var _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BottomNavigationBloc>(
      create: (context) => BottomNavigationBloc(),
      child: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
        builder: (context, state) {
          if (_pageController.hasClients) {
            _pageController.animateToPage(state.position,
                duration: Duration(microseconds: 500), curve: Curves.ease);
          }
          return Builder(builder: (context) {
            return Scaffold(
              body: PageView(
                physics: ClampingScrollPhysics(),
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                children: _screenList,
                onPageChanged: (position) {
                  context.read<BottomNavigationBloc>().add(EventBottomNavigationChange(position));
                },
              ),
              backgroundColor: Colors.white,
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Colors.white,
                selectedFontSize: AppDimen.TEXT_SMALL,
                unselectedFontSize: AppDimen.TEXT_SMALL,
                selectedItemColor: AppColor.violet,
                items: [
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                  BottomNavigationBarItem(icon: Icon(Icons.post_add), label: "Posts"),
                  BottomNavigationBarItem(icon: Icon(Icons.people), label: "Profile")
                ],
                currentIndex: state.position,
                onTap: (position) {
                  _pageController.animateToPage(position,
                      duration: Duration(microseconds: 500), curve: Curves.ease);
                },
              ),
            );
          });
        },
      ),
    );
  }
}
