import 'package:flutter/material.dart';
import 'package:sendapp/model/card.dart';
import 'package:sendapp/utils/constants.dart';

import 'add_card.dart';
class PaymentMethod extends StatefulWidget {
  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  static const kLightGray = Color(0xFFF0F3F8);
  List<CardDetails> cards = new List<CardDetails>();

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
                    var result = await Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) => AddCard()));
                    if (result != null) {
                      //add to list
                      setState(() {
                        cards.add(result);
                        cardVisible = true;
                      });
                    }
                  },
                  child: Container(
                    width: mediaQuery.size.width * 0.90,
                    height: mediaQuery.size.width * 0.45,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/icon-add-circle.png',
                          scale: 3,
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
            SizedBox(
              height: 32,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 16),
                child: Image.asset(
                  'assets/$image.png',
                  scale: 10,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Text(
                  card.number,
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
                  card.expiry,
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
                  card.name,
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
}
