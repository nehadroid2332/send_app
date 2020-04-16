import 'package:flutter/material.dart';

class ReusableSettingCard extends StatelessWidget {
  ReusableSettingCard({@required this.colour, this.cardChild, this.onPress});

  final Color colour;
  final Widget cardChild;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: cardChild,
        ),
        decoration: BoxDecoration(
          color: colour,
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}