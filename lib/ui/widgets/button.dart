
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sendapp/utils/constants.dart';

class ReusableButton extends StatelessWidget {
  ReusableButton({@required this.text, this.ico, this.onPress});

  final String text;
  final IconData ico;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: MediaQuery.of(context).size.width,
      height: 20,
      child: RaisedButton(

        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(36.0),
            side: BorderSide(color: greenColor, width: 2)),
        onPressed: onPress,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                ico,
                size: 16,
              ),
              SizedBox(
                width: 4,
              ),
              Text(text,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
            ],
          ),
        ),
        color: greenColor,
        textColor: Colors.white,
        elevation: 1,
      ),
    );
  }
}
