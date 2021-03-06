import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sendapp/model/order_model.dart';
import 'package:sendapp/services/user_repo.dart';
import 'package:sendapp/ui/widgets/button.dart';
import 'package:sendapp/utils/constants.dart';

import '../reusable_card.dart';

class DeliveryOptions extends StatefulWidget {
  final TabController tabController;

  const DeliveryOptions({Key key, this.tabController}) : super(key: key);

  @override
  _DeliveryOptionsState createState() => _DeliveryOptionsState();
}

class _DeliveryOptionsState extends State<DeliveryOptions> {
//generate Dates
  static DateTime now = DateTime.now();
  List<DateTime> dates = List.generate(
      4, (counter) => now.add(Duration(days: counter + 1)).toLocal()).toList();
  List<String> time = ["Morning", "Afternoon", "Evening", "Night"];

  //time selection
  List<bool> _timeSelection = [true, false, false, false];

//toggle delivery buttons
  List<bool> _deliverySelections = [true, false];

//toggle dates
  List<bool> _dateSelections = [true, false, false, false, false];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    RepositoryProvider.of<UserRepo>(context);
    print(new DateFormat.MMMd().format(new DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Select Type',
                        style: kTextH2,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  //delivery option
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ToggleButtons(
                      renderBorder: false,
                      children: [
                        Container(
                            height: height * 0.19,
                            width: width * 0.42,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                                color: _deliverySelections[0]
                                    ? lightGreyColor
                                    : lighterGreyColor,
                                borderRadius: BorderRadius.circular(12)),
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.asset(
                                  'assets/icon-delivery.png',
                                  scale: 3,
                                  color: mediumGreyColor2,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  'Standard',
                                  style: TextStyle(
                                      color: mediumGreyColor2,
                                      fontSize: width*0.05,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  '2-3 Days (free)',
                                  style: TextStyle(
                                      color: mediumGreyColor1,
                                      fontSize: 12,
                                      fontFamily: 'Acumin'),
                                ),
                                CircularCheckBox(
                                  activeColor: greenColor,
                                  value: _deliverySelections[0],
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.padded,
                                  onChanged: (_) {},
                                ),
                              ],
                            )),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          height: height * 0.19,
                          width: width * 0.42,
                          decoration: BoxDecoration(
                              color: _deliverySelections[1]
                                  ? lightGreyColor
                                  : lighterGreyColor,
                              borderRadius: BorderRadius.circular(12)),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Image.asset(
                                'assets/icon-fast-delivery.png',
                                scale: 3,
                                color: mediumGreyColor2,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Supersonic',
                                style: kTextHeading,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                '2-3 Hours (free)',
                                style: kTextBody2,
                              ),
                              CircularCheckBox(
                                  activeColor: greenColor,
                                  value: _deliverySelections[1],
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.padded,
                                  onChanged: (_) {}),
                            ],
                          ),
                        ),
                      ],
                      isSelected: _deliverySelections,
                      fillColor: whiteColor,
                      splashColor: whiteColor,
                      onPressed: (int index) {
                        setState(() {
                          for (int val = 0;
                              val < _deliverySelections.length;
                              val++) {
                            if (val == index) {
                              _deliverySelections[val] = true;
                            } else {
                              _deliverySelections[val] = false;
                            }
                          }
//                          _selections[index] =!_selections[index];
                        });
                      },
                    ),
                  ),

                  AnimatedOpacity(
                      opacity: _deliverySelections[1] ? 0 : 1,
                      duration: Duration(seconds: 1),
                      child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16, top: 28, bottom: 4),
                          child: Text(
                            'Select Date',
                            style: kTextH2,
                          ))),

                  //time selections
                  AnimatedOpacity(
                    opacity: _deliverySelections[1] ? 0 : 1,
                    duration: Duration(seconds: 1),
                    child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ToggleButtons(
                          renderBorder: false,
                          fillColor: whiteColor,
                          splashColor: whiteColor,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              margin: EdgeInsets.symmetric(horizontal: 12),
                              height: height * 0.09,
                              width: width * 0.25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: _dateSelections[0]
                                    ? lightGreyColor
                                    : lighterGreyColor,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '${DateFormat.MMMd().format(DateTime.now())}',
                                overflow: TextOverflow.ellipsis,
                                style: kTextBodyH1,
                              ), /*Row(
                              children: <Widget>[
                                CircularCheckBox(
                                    disabledColor: greenColor,
                                    value: _dateSelections[0],
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.padded,
                                    onChanged: null),
                                Text(
                                  '${DateFormat.MMMd().format(DateTime.now())}',
                                  overflow: TextOverflow.ellipsis,
                                  style: kTextBody,
                                ),
                              ],
                            )*/
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              margin: EdgeInsets.symmetric(horizontal: 12),
                              height: height * 0.09,
                              width: width * 0.25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: _dateSelections[1]
                                    ? lightGreyColor
                                    : lighterGreyColor,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '${DateFormat.MMMd().format(dates[0])}',
                                overflow: TextOverflow.ellipsis,
                                style: kTextBodyH1,
                              ), /*Row(
                              children: <Widget>[
                                CircularCheckBox(
                                    activeColor: greenColor,
                                    value: _dateSelections[1],
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.padded,
                                    onChanged: null),
                                Text(
                                  '${DateFormat.MMMd().format(dates[0])}',
                                  overflow: TextOverflow.ellipsis,
                                  style: kTextHeading,
                                ),
                              ],
                            ),*/
                            ),
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              margin: EdgeInsets.symmetric(horizontal: 12),
                              height: height * 0.09,
                              width: width * 0.25,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: _dateSelections[2]
                                      ? lightGreyColor
                                      : lighterGreyColor),
                              child: Text(
                                '${DateFormat.MMMd().format(dates[1])}',
                                overflow: TextOverflow.ellipsis,
                                style: kTextBodyH1,
                              ), /*Row(
                              children: <Widget>[
                                CircularCheckBox(
                                    activeColor: greenColor,
                                    value: _dateSelections[2],
                                    materialTapTargetSize:
                                    MaterialTapTargetSize.padded,
                                    onChanged: (_) {}),
                                Text(
                                  '${DateFormat.MMMd().format(dates[1])}',
                                  overflow: TextOverflow.ellipsis,
                                  style: kTextHeading,
                                ),
                              ],
                            ),*/
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              margin: EdgeInsets.symmetric(horizontal: 12),
                              height: height * 0.09,
                              width: width * 0.25,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: _dateSelections[3]
                                      ? lightGreyColor
                                      : lighterGreyColor),
                              child: Text(
                                '${DateFormat.MMMd().format(dates[2])}',
                                overflow: TextOverflow.ellipsis,
                                style: kTextBodyH1,
                              ), /*Row(
                              children: <Widget>[
                                CircularCheckBox(
                                    activeColor: greenColor,
                                    value: _dateSelections[3],
                                    materialTapTargetSize:
                                    MaterialTapTargetSize.padded,
                                    onChanged: (_) {}),
                                Text(
                                  '${DateFormat.MMMd().format(dates[2])}',
                                  overflow: TextOverflow.ellipsis,
                                  style: kTextHeading,
                                ),
                              ],
                            ),*/
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              margin: EdgeInsets.symmetric(horizontal: 12),
                              height: height * 0.09,
                              width: width * 0.25,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: _dateSelections[4]
                                      ? lightGreyColor
                                      : lighterGreyColor),
                              child: Text(
                                '${DateFormat.MMMd().format(dates[3])}',
                                overflow: TextOverflow.ellipsis,
                                style: kTextHeading,
                              ), /*Row(
                              children: <Widget>[
                                CircularCheckBox(
                                    activeColor: greenColor,
                                    value: _dateSelections[4],
                                    materialTapTargetSize:
                                    MaterialTapTargetSize.padded,
                                    onChanged: (_) {}),
                                Text(
                                  '${DateFormat.MMMd().format(dates[3])}',
                                  overflow: TextOverflow.ellipsis,
                                  style: kTextHeading,
                                ),
                              ],
                            ),*/
                            ),
                          ],
                          isSelected: _dateSelections,
                          onPressed: (index) {
                            setState(() {
                              for (int val = 0;
                                  val < _dateSelections.length;
                                  val++) {
                                if (val == index) {
                                  _dateSelections[val] = true;
                                } else {
                                  _dateSelections[val] = false;
                                }
                              }
                            });
                          },
                        )),
                  ),

                  AnimatedOpacity(
                      duration: Duration(seconds: 1),
                      opacity: _deliverySelections[1]||_dateSelections[0]?0:1,
                    child: Padding(
                        padding:
                            const EdgeInsets.only(left: 16, top: 25, bottom: 4),
                        child: Text(
                          'Select Time',
                          style: kTextH2,
                        ),),
                  ),

            AnimatedOpacity(
              duration: Duration(seconds: 1),
              opacity: _deliverySelections[1]|| _dateSelections[0]?0:1,
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ToggleButtons(
                      renderBorder: false,
                      children: [
                        Container(
                          height: height * 0.08,
                          width: width * 0.3,
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                              color: _timeSelection[0]
                                  ? lightGreyColor
                                  : lighterGreyColor,
                              borderRadius: BorderRadius.circular(12)),
                          alignment: Alignment.center,
                          child: Text(
                            'Morning',
                            overflow: TextOverflow.ellipsis,
                            style: kTextBodyH1,
                          ), /*Row(
                            children: <Widget>[
                              CircularCheckBox(
                                  activeColor: greenColor,
                                  value: _timeSelection[0],
                                  materialTapTargetSize:
                                  MaterialTapTargetSize.padded,
                                  onChanged: (_) {}),
                              Text(
                                'Morning',
                                overflow: TextOverflow.ellipsis,
                                style: kTextHeading,
                              ),
                            ],
                          ),*/
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          height: height * 0.08,
                          width: width * 0.3,
                          decoration: BoxDecoration(
                              color: _timeSelection[1]
                                  ? lightGreyColor
                                  : lighterGreyColor,
                              borderRadius: BorderRadius.circular(12)),
                          alignment: Alignment.center,
                          child: Text(
                            'Afternoon',
                            overflow: TextOverflow.ellipsis,
                            style: kTextBodyH1,
                          ), /*Row(
                            children: <Widget>[
                              CircularCheckBox(
                                  activeColor: greenColor,
                                  value: _timeSelection[1],
                                  materialTapTargetSize:
                                  MaterialTapTargetSize.padded,
                                  onChanged: (_) {}),
                              Text(
                                'Afternoon',
                                overflow: TextOverflow.ellipsis,
                                style: kTextBodyH1,
                              ),
                            ],
                          ),*/
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          height: height * 0.08,
                          width: width * 0.3,
                          decoration: BoxDecoration(
                              color: _timeSelection[2]
                                  ? lightGreyColor
                                  : lighterGreyColor,
                              borderRadius: BorderRadius.circular(12)),
                          alignment: Alignment.center,
                          child: Text(
                            'Evening',
                            overflow: TextOverflow.ellipsis,
                            style: kTextHeading,
                          ), /*Row(
                            children: <Widget>[
                              CircularCheckBox(
                                  value: _timeSelection[2],

                                  disabledColor: greenColor,
                                  materialTapTargetSize:
                                  MaterialTapTargetSize.padded,
                                  onChanged: null),
                              Text(
                                'Evening',
                                overflow: TextOverflow.ellipsis,
                                style: kTextHeading,
                              ),
                            ],
                          ),*/
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          height: height * 0.08,
                          width: width * 0.3,
                          decoration: BoxDecoration(
                              color: _timeSelection[3]
                                  ? lightGreyColor
                                  : lighterGreyColor,
                              borderRadius: BorderRadius.circular(12)),
                          alignment: Alignment.center,
                          child: Text(
                            'Night',
                            overflow: TextOverflow.ellipsis,
                            style: kTextBodyH1,
                          ), /*Row(
                            children: <Widget>[
                              CircularCheckBox(
                                  activeColor: greenColor,
                                  value: _timeSelection[3],
                                  materialTapTargetSize:
                                  MaterialTapTargetSize.padded,
                                  onChanged: (_) {}),
                              Text(
                                'Night',
                                overflow: TextOverflow.ellipsis,
                                style: kTextHeading,
                              ),
                            ],
                          ),*/
                        ),
                      ],
                      isSelected: _timeSelection,
                      fillColor: whiteColor,
                      splashColor: whiteColor,
                      onPressed: (int index) {
                        setState(() {
                          for (int val = 0;
                              val < _timeSelection.length;
                              val++) {
                            if (val == index) {
                              _timeSelection[val] = true;
                            } else {
                              _timeSelection[val] = false;
                            }
                          }
                        });
                      },
                    ),
                  ),),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: ReusableButton(
                      text: "Continue",
                      ico: Icons.arrow_forward,
                      onPress: () {
                        //fixme:add delivery date and delivery time to the order Model
                       /* var orderModel =
                            RepositoryProvider.of<UserRepo>(context).orderModel;
                        RepositoryProvider.of<UserRepo>(context).orderModel =
                            orderModel.copyWith(
                                deliveryDate:
                                    dates[_dateSelections.indexOf(true)]
                                        .toString(),
                                deliveryTime:
                                    time[_timeSelection.indexOf(true)]);*/
                        widget.tabController.animateTo(2);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
