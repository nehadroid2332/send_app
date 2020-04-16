import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sendapp/bloc/address/address_bloc.dart';
import 'package:sendapp/services/user_repo.dart';
import 'package:sendapp/ui/widgets/tabs/delivery_address.dart';
import 'package:sendapp/ui/widgets/tabs/delivery_option.dart';
import 'package:sendapp/ui/widgets/tabs/payment_method.dart';
import 'package:sendapp/utils/constants.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  final List<String> _title = [
    'Delivery Address',
    'Delivery Options',
    'Payment Method',
    "Order Successful"
  ];
  int index = 0;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this)
      ..addListener(() {
        setState(() {
          index = _tabController.index ?? 0;
        });
      });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: whiteColor,
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              CupertinoIcons.back,
              color: greenColor,
            ),
            onPressed: () => Navigator.pop(context)),
        title: Text(
          "${_title[index ?? 0]}",
          style: kTextHeading,
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: TabBar(
                controller: _tabController,
                indicatorColor: greenColor,
                onTap: null,
                indicator: BoxDecoration(
                    color: greenColor, borderRadius: BorderRadius.circular(25)),
                tabs: [
                  Tab(
                    child: ImageIcon(
                      AssetImage('assets/icon-location.png'),
                      color: index == 0 ? whiteColor : greenColor,
                    ),
                  ),
                  Tab(
                    child: ImageIcon(
                      AssetImage('assets/icon-delivery.png'),
                      color: index == 1 ? whiteColor : greenColor,
                    ),
                  ),
                  Tab(
                    child: ImageIcon(
                      AssetImage('assets/icon-payment.png'),
                      color: index == 2 ? whiteColor : greenColor,
                    ),
                  ),
//          Tab(child: ImageIcon(AssetImage('assets/icon-summary.png'),color:index==3? whiteColor:greenColor,),),
                ]),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: [
            BlocProvider(
               create: (context)=>AddressBloc(repo: RepositoryProvider.of<UserRepo>(context)),
              child:   DeliveryAddress(
                tabController: _tabController,
              ),
            ),
//            DeliveryAddress(
//              tabController: _tabController,
//            ),
            DeliveryOptions(
              tabController: _tabController,
            ),
            PaymentMethod(),
//            DeliveryAddress(),
          ]),
    );
  }
}
