import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sendapp/model/card.dart';
import 'package:sendapp/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'add_card.dart';

class PaymentMethod extends StatefulWidget {
  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  static const kLightGray = Color(0xFFF0F3F8);
  List<Token> cards = new List<Token>();

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    bool cardVisible = false;
    if (cards.length != 0) {
      cardVisible = true;
    }

    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 8,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 8,
                ),
                child: Text(
                  'Add Card',
                  textAlign: TextAlign.left,
                  style: kTextH2,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () async {
                    //launch different screen
                    await Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) => AddCard()));
                    //add to list
                    setState(() {
                      init();
                    });
                  },
                  child: Container(
                    width: mediaQuery.size.width * 0.90,
                    height: mediaQuery.size.width * 0.45,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.add_circle_outline,
                          size: 40,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'ADD CARD',
                          style: kTextBoldMed,
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: kLightGray,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: cardVisible,
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 8,
                  ),
                  child: Text(
                    'Saved Cards',
                    textAlign: TextAlign.left,
                    style: kTextH2,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: cardVisible,
              child: SizedBox(
                height: mediaQuery.size.width * 0.50,
                child: ListView.builder(
                  padding: EdgeInsets.only(left: 16),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) =>
                      buildCard(context, index),
                  itemCount: cards.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard(BuildContext context, int index) {
    final card = cards[index];
    String image;
    if (card.type == 0) {
      image = 'master';
    }
    if (card.type == 1) {
      image = 'visa';
    }
    if (card.type == 2) {
      image = 'verve';
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * (0.80),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.credit_card,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        "${card.card.brand}",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Text(
                  card.card.last4,
                  style: kTextBoldMedWhite,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Text(
                  "${card.card.expMonth}/${card.card.expYear}",
                  style: kTextBoldMedWhite,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Text(
                  card.billingDetails.name,
                  style: kTextBoldMedWhite,
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
          ],
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[Color(0xFF434343), Color(0xFF000000)],
            stops: <double>[0.0, 0.7],
            begin: Alignment(-1.0, -2.0),
            end: Alignment(1.0, 2.0),
          ),
          color: kLightGray,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }

  void init() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final list = sharedPreferences.getStringList("tokens");
    if (list != null) {
      setState(() {
        cards.clear();
        cards.addAll(list
            .map((s) => json.decode(s))
            .map((s) => Token.fromJson(s))
            .toList());
      });
    }
  }
}
