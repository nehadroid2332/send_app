import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sendapp/model/card.dart';
import 'package:sendapp/model/user.dart';
import 'package:sendapp/services/user_repo.dart';
import 'package:sendapp/ui/custom_widget/circular_switch.dart';
import 'package:sendapp/ui/widgets/reusable_card.dart';
import 'package:sendapp/utils/constants.dart';

class YourAccountScreen extends StatefulWidget {
  final UserModel userDetails;

  const YourAccountScreen({Key key, this.userDetails}) : super(key: key);
  @override
  _YourAccountScreenState createState() => _YourAccountScreenState();
}

class _YourAccountScreenState extends State<YourAccountScreen> {
  @override
  Widget build(BuildContext context) {
    List<CardDetails> cards = new List<CardDetails>();


    //TODO: Hardcode Remaining ADD screen Link
    cards.add(CardDetails("Chris Perllo", "1234567896544", "12/23", 23, 0));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.maybePop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: mediumGreyColor2,
          ),
        ),
        backgroundColor: whiteColor,
        title: Text(
          'Your Account',
          style: kTextHeading,
        ),
        centerTitle: true,
        elevation: 0,
        /*actions: [
          GestureDetector(
              onTap: () {
                //confirm Button
              },
              child: Image.asset('assets/icons/icon-tick.png')),
        ],*/
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Your Information',
                style: kTextBodyH1,
              ),
              SizedBox(
                height: 25,
              ),
              ReusableCard(
                colour: lighterGreyColor,
                cardChild: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text('Full Name', style: kTextBodyH2),
                    SizedBox(
                      height: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                            child: Text(
                              "${widget.userDetails.firstName} ${widget.userDetails.lastName}",
                              style: kTextBodyP,
                              overflow: TextOverflow.ellipsis,
                            )),
                        GestureDetector(
                            onTap: () {},
                            child: Image.asset('assets/icons/icon-edit.png')),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('Address', style: kTextBodyH2),
                    SizedBox(
                      height: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Text("43 street demo",
//                            RepositoryProvider.of<UserRepo>(context).address.address,
                            style: kTextBodyP,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        GestureDetector(
                            onTap: () {},
                            child: Image.asset('assets/icons/icon-edit.png')),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('Email', style: kTextBodyH2),
                    SizedBox(
                      height: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            widget.userDetails.email,
                            style: kTextBodyP,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        GestureDetector(
                            onTap: () {},
                            child: Image.asset('assets/icons/icon-edit.png')),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    /*Text('Password', style: kTextBodyH2),
                    SizedBox(
                      height: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          password,
                          style: kTextBodyP,
                          overflow: TextOverflow.ellipsis,
                        ),
                        GestureDetector(
                            onTap: () {},
                            child: Image.asset('assets/icons/icon-edit.png')),
                      ],
                    ),*/
                  ],
                ),
              ),
              SizedBox(
                height: 22,
              ),
              Text(
                'Your Preferences',
                style: kTextBodyH1,
              ),
              SizedBox(
                height: 25,
              ),
              ReusableCard(
                colour: lighterGreyColor,
                cardChild: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            'Notifications',
                            style: kTextBodyH2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        CircularSwitch(
                          value: true,
                          onChanged: (value) {
                            print(value);
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            'Newsletter',
                            style: kTextBodyH2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        CircularSwitch(
                          onChanged: (value) {
                            print(value);
                          },
                          value: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 22,
              ),
              Text(
                'Payment Method',
                style: kTextBodyH1,
              ),
              SizedBox(
                height: 25,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 280,
                        height: 180,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 25),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                'assets/icons/icon-add-circle.png',
                                width: 49,
                                height: 49,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'ADD CARD',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Acumin Pro SemiCondensed',
                                  color: mediumGreyColor2,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: lighterGreyColor,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    Container(
                      height: 180,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.only(left: 16),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) =>
                            buildCard(context, index, cards[index]),
                        itemCount: cards.length,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


Widget buildCard(BuildContext context, int index, CardDetails card) {
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
  return Container(
    width: 284,
    height: 180,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 34),
          child: Image.asset(
            'assets/$image.png',
            height: 32,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Text(
            '**** **** **** ${card.number.substring(card.number.length - 4)}',
            style: TextStyle(
              fontSize: 16,
              letterSpacing: 3.2,
              fontFamily: 'Acumin Pro SemiCondensed',
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          height: 17,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                card.name,
                style: TextStyle(
                  letterSpacing: -0.16,
                  fontFamily: 'Acumin Pro SemiCondensed',
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              Text(
                card.expiry,
                style: TextStyle(
                  fontFamily: 'Acumin Pro SemiCondensed',
                  letterSpacing: -0.16,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    decoration: BoxDecoration(
      color: mediumGreyColor2,
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
  );
}


