import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sendapp/bloc/authenticaion/authentication_bloc.dart';
import 'package:sendapp/bloc/authenticaion/authentication_event.dart';
import 'package:sendapp/model/user.dart';
import 'package:sendapp/ui/widgets/reusable_setting_card.dart';
import 'package:sendapp/utils/constants.dart';

import 'account_screen.dart';
class SettingScreen extends StatefulWidget {
  final UserModel user;

  const SettingScreen({Key key, this.user}) : super(key: key);
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Text(
          "Settings",
          style: kTextHeading,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) {
                    return YourAccountScreen(userDetails: widget.user,);
                  }),
                );
              },
              child: ReusableSettingCard(
                colour: lighterGreyColor,
                cardChild: Row(
                  children: [
                    ImageIcon(
                      AssetImage(
                        'assets/icons/icon-account.png',
                      ),
                      color: greenColor,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Your Account',
                      style: kTextBodyP2,
                    ),
                    Spacer(),
                    RotatedBox(
                        quarterTurns: 15,
                        child: Image.asset(
                          'assets/icons/icon-chevron.png',
                          height: 8,
                        )),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            GestureDetector(
              onTap: () {
                //Navigate Your order
              },
              child: ReusableSettingCard(
                colour: lighterGreyColor,
                cardChild: Row(
                  children: [
                    ImageIcon(
                      AssetImage(
                        'assets/icons/icon-orders.png',
                      ),
                      color: greenColor,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Your Orders',
                      style: kTextBodyP2,
                    ),
                    Spacer(),
                    RotatedBox(
                        quarterTurns: 15,
                        child: Image.asset(
                          'assets/icons/icon-chevron.png',
                          height: 8,
                        )),
                  ],
                ),
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                //Sign out
                BlocProvider.of<AuthenticationBloc>(context)..add(LoggedOut());
              },
              child: ReusableSettingCard(
                colour: lighterGreyColor,
                cardChild: Row(
                  children: [
                    ImageIcon(
                      AssetImage(
                        'assets/icons/icon-sign-out.png',
                      ),
                      color: greenColor,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Sign Out',
                      style: kTextBodyP2,
                    ),
                    Spacer(),
                    Spacer(),
                    RotatedBox(
                      quarterTurns: 15,
                      child: Image.asset(
                        'assets/icons/icon-chevron.png',
                        height: 8,
                      ),
                    ),
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
