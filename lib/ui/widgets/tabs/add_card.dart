import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sendapp/model/card.dart';
import 'package:sendapp/utils/constants.dart';
import '../button.dart';
class AddCard extends StatefulWidget {
  @override
  _AddCardState createState() => _AddCardState();
}

enum CardType { MasterCard, Visa, Verve, Others, Invalid }

class _AddCardState extends State<AddCard> {
  static const kDarkGray = Color(0xFF7C8995);
  String name, expiry, number;
  int code;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context, null);
              },
              child: Icon(
                Icons.close,
                color: kDarkGray,
              ),
            ),
          ),
        ],
        title: Text(
          'Add Card',
          style: TextStyle(color: Colors.black54),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              child: TextField(
                onChanged: (val) {
                  name = val;
                },
                decoration: InputDecoration(
                  filled: true,
                  hintText: 'Cardholder Name',
                  hintStyle: kTextBody,
                  fillColor: Color(0xFFF0F3F8),
                  prefixIcon: Image.asset('assets/icon-account.png',scale: 3,),
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                ),
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              child: TextField(
                onChanged: (val) {
                  number = val;
                },
                inputFormatters: [
                  WhitelistingTextInputFormatter.digitsOnly,
                  new LengthLimitingTextInputFormatter(19),
                  new CardNumberInputFormatter()
                ],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  hintText: 'Card Numbers',
                  hintStyle: kTextBody,
                  fillColor: Color(0xFFF0F3F8),
                  prefixIcon: Image.asset('assets/icon-payment-4.png',scale: 3,),
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                ),
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              child: TextField(
                onChanged: (val) {
                  expiry = val;
                },
                inputFormatters: [
                  WhitelistingTextInputFormatter.digitsOnly,
                  new LengthLimitingTextInputFormatter(4),
                  new CardMonthInputFormatter()
                ],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  hintText: 'Expiry Date',
                  hintStyle: kTextBody,
                  fillColor: Color(0xFFF0F3F8),
                                   prefixIcon: Image.asset('assets/icon-calendar.png',scale: 3),

                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                ),
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              child: TextField(
                onChanged: (val1) {
                  code = int.parse(val1);
                },
                keyboardType: TextInputType.number,
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  hintText: 'Security Code',
                  hintStyle: kTextBody,
                  fillColor: Color(0xFFF0F3F8),
                  prefixIcon: Image.asset('assets/icon-secure.png',scale: 3,),
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                ),
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ReusableButton(
                      onPress: () {
                        /*if (name != null &&
                            number != null &&
                            expiry != null &&
                            code != null) {
                          int type =
                          getCardTypeFrmNumber(number.replaceAll(' ', ''));
                          CardDetails card =
                          CardDetails(name, number, expiry, code, type);
                          Navigator.pop(context, card);
                        } else {
                          showAlertDialog(context, 'Field Empty',
                              'Please check one or more field is empty');
                        }*/
                      },
                      text: 'Continue',
                      ico: Icons.arrow_forward,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

int getCardTypeFrmNumber(String input) {
  int cardType;
  if (input.startsWith(new RegExp(
      r'((5[1-5])|(222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720))'))) {
    cardType = 0;
  } else if (input.startsWith(new RegExp(r'[4]'))) {
    cardType = 1;
  } else if (input.startsWith(new RegExp(r'((506(0|1))|(507(8|9))|(6500))'))) {
    cardType = 2;
  } else if (input.length <= 8) {
    cardType = 3;
  } else {
    cardType = 4;
  }
  return cardType;
}

class CardMonthInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != newText.length) {
        buffer.write('/');
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length));
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write('  '); // Add double spaces.
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length));
  }
}
