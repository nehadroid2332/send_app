import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sendapp/bloc/address/address_bloc.dart';
import 'package:sendapp/bloc/address/address_event.dart';
import 'package:sendapp/bloc/address/address_state.dart';
import 'package:sendapp/model/address.dart';
import 'package:sendapp/model/user.dart';
import 'package:sendapp/ui/custom_widget/address_search.dart';
import 'package:sendapp/ui/custom_widget/latlng_model.dart';
import 'package:sendapp/ui/widgets/button.dart';
import 'package:sendapp/utils/constants.dart';

class DeliveryAddress extends StatefulWidget {
  final TabController tabController;

  const DeliveryAddress({Key key, this.tabController}) : super(key: key);

  @override
  _DeliveryAddressState createState() => _DeliveryAddressState();
}

class _DeliveryAddressState extends State<DeliveryAddress> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();
  String address;
  UserModel user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var address = BlocProvider.of<AddressBloc>(context).repo.addresses;
    print(address);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: BlocProvider.of<AddressBloc>(context),
      listener: (context, state) {
        if (state is AddressLoading) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Adding.."),
                    CircularProgressIndicator()
                  ],
                ),
              ),
            );
        } else if (state is AddressLoadingFail) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(state.reason),
                  ],
                ),
              ),
            );
        } else if (state is AddressAdded) {
          Scaffold.of(context)
            ..hideCurrentSnackBar();
          widget.tabController.animateTo(1);
        }
      },
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: TextFormField(
                            controller: _nameController,
                            onChanged: (val) {},
                            validator: (val) {
                              return val.length < 2
                                  ? "pleaser enter Valid Name"
                                  : null;
                            },
                            decoration: InputDecoration(
                              filled: true,
                              hintText: 'Name',
                              hintStyle: kTextBody,
                              fillColor: Color(0xFFF0F3F8),
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
                            style: kTextBody),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      /*TextFormField(
                          onChanged: (val) {},
                          validator: (val) {
                            return val.length < 2
                                ? "pleaser enter HouseNumber"
                                : null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            hintText: 'House Number',
                            hintStyle: kTextBody,
                            fillColor: Color(0xFFF0F3F8),
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
                          style: kTextBody)*/
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: SearchMapPlaceWidget(
                          apiKey: Constants.GOOGLE_API_KEY,
                          icon: CupertinoIcons.search,
                          iconColor: greenColor,
                          placeholder: "Type Address",
                          radius: 0,
                          onSearch: (place) {
                            print("asdasdasdasdasdas");
                            setState(() {
                              address = place;
                            });
                          },
                          onSelected: (place) {
                            print(place.toString());
                            setState(() {
                              address = place.description;
                            });
                          },
                          location: LatLng(1212.12, 1223.12),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                        Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: TextFormField(
                          onChanged: (val) {},
                          validator: (val) {
                            return val.length < 2
                                ? "pleaser enter Valid Street Address"
                                : null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            hintText: 'Second Address',
                            hintStyle: kTextBody,
                            fillColor: Color(0xFFF0F3F8),
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
                          style: kTextBody),
                    ),
                      SizedBox(
                        height: 8,
                      ),
                      /*  SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: TextFormField(
                          onChanged: (val) {},
                          validator: (val) {
                            return val.length < 2
                                ? "pleaser enter Valid Town"
                                : null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            hintText: 'Town/City',
                            hintStyle: kTextBody,
                            fillColor: Color(0xFFF0F3F8),
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
                          style: kTextBody),
                    ),
                    SizedBox(
                      height: 8,
                    ),*/
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: TextFormField(
                            controller: _pinCodeController,
                            keyboardType: TextInputType.number,
                            onChanged: (val) {},
                            validator: (val) {
                              return val.length < 2
                                  ? "pleaser enter Valid Pin Code"
                                  : null;
                            },
                            decoration: InputDecoration(
                              filled: true,
                              hintText: 'Pin Code',
                              hintStyle: kTextBody,
                              fillColor: Color(0xFFF0F3F8),
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
                            style: kTextBody),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: EdgeInsets.all(12),
                child: ReusableButton(
                  ico: Icons.arrow_forward,
                  text: "Continue",
                  onPress: () {
                    if (_formKey.currentState.validate()) {
                      BlocProvider.of<AddressBloc>(context)
                        ..add(AddAddress(
                            address: address,
                            name: _nameController.text,
                            postalCode: _pinCodeController.text));
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
