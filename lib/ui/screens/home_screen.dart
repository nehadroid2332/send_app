import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:sendapp/bloc/authenticaion/authentication_bloc.dart';
import 'package:sendapp/bloc/authenticaion/bloc.dart';
import 'package:sendapp/bloc/cart_bloc/cart_bloc.dart';
import 'package:sendapp/bloc/category_bloc/category_bloc.dart';
import 'package:sendapp/bloc/category_bloc/category_event.dart';
import 'package:sendapp/services/cart_repo.dart';
import 'package:sendapp/services/categories_repo.dart';
import 'package:sendapp/services/user_repo.dart';
import 'package:sendapp/ui/screens/option.dart';
import 'package:sendapp/ui/screens/storePage.dart';
import 'package:sendapp/utils/constants.dart';
import 'package:sendapp/utils/toole.dart';

import 'cart.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {

  int currentTabIndex = 0;
  CupertinoTabController _tabController =
      CupertinoTabController(initialIndex: 0);

FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");

      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");

      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");

      },
    );
    _tabController.addListener(() {
      setState(() {

      });
      print(_tabController.index);
    });
    // TODO: implement initState
    super.initState();
    checkServiceEnable();
    checkPermission();
    location.getLocation().then((value) => print(value.longitude));
  }

  @override
  Widget build(BuildContext context) {
    print("home builder");
    return CupertinoTabScaffold(
      backgroundColor: lighterGreyColor,
      controller: _tabController,
      tabBar: CupertinoTabBar(
          backgroundColor: whiteColor,
          currentIndex: _tabController.index,
          border: Border(top: BorderSide.none),
          activeColor: greenColor,
          onTap: (index) {
            setState(() {
              _tabController.index = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/icon-store.png",
                  scale: 2.5,
                  color:
                      _tabController.index == 0 ? greenColor : mediumGreyColor1,
                ),
                title: Text("")),
            BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/icon-cart.png",
                  scale: 2.5,
                  color:
                      _tabController.index == 1 ? greenColor : mediumGreyColor1,
                ),
                title: Text("")),
            BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/icon-settings.png",
                  scale: 2.5,
                  color:
                      _tabController.index == 2 ? greenColor : mediumGreyColor1,
                ),
                title: Text("")),
          ]),

      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return BlocProvider(
                create: (context) => CategoryBloc(
                    repo: context.repository<CategoriesRepository>(),
                    catRepo: context.repository<CartRepo>())
                  ..add(LoadCategories()),
                child: StorePage());
            break;
          case 1:
            return CartScreen(
              tabController: _tabController,
            );
            break;
          case 2:
            return BlocProvider(
              create: (context) => AuthenticationBloc(
                  userRepository: context.repository<UserRepo>())
                ..add(AppStarted()),
              child: OptionScreen(),
            );
            break;
          default:
            return Container();
            break;
        }
      },
    );
  }
}
