import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:sendapp/bloc/order/order_bloc.dart';
import 'package:sendapp/model/order_model.dart';
import 'package:sendapp/model/product.dart';
import 'package:sendapp/services/cart_repo.dart';
import 'package:sendapp/services/user_repo.dart';
import 'package:sendapp/ui/screens/product_detail_screen.dart';
import 'package:sendapp/utils/constants.dart';

import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  final CupertinoTabController tabController;

  const CartScreen({Key key, this.tabController}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartRepo cartRepo;
  UserRepo userRepo;
  List<Product> product = [];
  final _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    cartRepo = RepositoryProvider.of<CartRepo>(context);
    userRepo = RepositoryProvider.of<UserRepo>(context);
    product = cartRepo.getProducts;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return CupertinoTabView(
      builder: (context) => Scaffold(
        key: _key,
        backgroundColor: whiteColor,
        appBar: AppBar(
          backgroundColor: whiteColor,
          centerTitle: true,
          elevation: 0,
          title: Text(
            'Cart',
            style: kTextHeading,
          ),
        ),
        body: cartRepo.getProducts.isNotEmpty
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return itemCard(
                            context: context,
                            index: index,
                            title: product[index].name,
                            quantity: product[index].quantity,
                            price: product[index].price,
                            imageUrl: product[index].image,
                            onEdit: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetail(
                                    product: product[index],
                                    notFromCart: false,
                                  ),
                                ),
                              );
                            },
                            onDelete: () {
                              setState(() {
                                cartRepo.deleteProduct(product[index]);
                                product = cartRepo.getProducts;
                              });
                            },
                          );
                        },
                        itemCount: cartRepo.getProducts.length,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Sub-total',
                          style: kTextHeading2,
                        ),
                        Text(
                          '\$${cartRepo.getTotal()}',
                          style: kTextHeading2,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Delivery',
                          style: kTextHeading2,
                        ),
                        Text(
                          'Standard (free)',
                          style: kTextHeading2,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Total',
                          style: TextStyle(
                              color: mediumGreyColor2,
                              fontSize: 24,
                              fontFamily: 'Acumin'),
                        ),
                        Text(
                          '\$${cartRepo.getTotal()}',
                          style: TextStyle(
                              color: mediumGreyColor2,
                              fontSize: 24,
                              fontFamily: 'Acumin'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    ButtonTheme(
                      minWidth: MediaQuery.of(context).size.width,
                      height: 20,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(36.0),
                            side: BorderSide(color: greenColor, width: 2)),
                        onPressed: () async {
                          //todo: move to Delivery Options
                          //check user is authenticated
                          bool islogin = await userRepo.isSignedIn();
                          if (islogin) {

                         userRepo.orderModel=   OrderModel(
                                itemList: cartRepo.getProducts
                                    .map((e) => ItemList(
                                        itemId: e.id,
                                        quantity: e.quantity.toString(),
                                        total: e.price.toString()))
                                    .toList());
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => BlocProvider(
                                    create: (context) => OrderBloc(),
                                    child: CheckoutScreen(),
                                  ),
                                ));
                          } else {
                            _key.currentState
                              ..hideCurrentSnackBar()
                              ..showSnackBar(SnackBar(
                                backgroundColor: greenColor,
                                content: Text("please Login first"),
                                action: SnackBarAction(
                                  label: "Ok",
                                  onPressed: () {
                                    print("pressed");
                                    widget.tabController.index = 2;
                                  },
                                  textColor: whiteColor,
                                ),
                              ));
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.arrow_forward,
                                size: 16,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text('CHECKOUT',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700)),
                            ],
                          ),
                        ),
                        color: greenColor,
                        textColor: Colors.white,
                        elevation: 1,
                      ),
                    ),
                  ],
                ),
              )
            : Center(
                child: Text(
                  "No Item in Cart",
                  style: kTextHeading,
                ),
              ),
      ),
    );
  }
}

Widget itemCard(
    {BuildContext context,
    int index,
    String title,
    double quantity,
    double price,
    String imageUrl,
    Function onEdit,
    Function onDelete}) {
  var mediaQuery = MediaQuery.of(context);
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Slidable(
        actionPane: SlidableBehindActionPane(),
        secondaryActions: <Widget>[
          IconSlideAction(
            color: lightGreyColor,
            closeOnTap: true,
            iconWidget: ImageIcon(
              AssetImage(
                "assets/icon-edit.png",
              ),
              color: whiteColor,
              size: 20,
            ),
            onTap: onEdit,
          ),
          IconSlideAction(
            color: mediumGreyColor1,
            // icon: Icons.delete,
            iconWidget: ImageIcon(
              AssetImage("assets/icon-trash.png"),
              color: whiteColor,
            ),
            onTap: onDelete,
          ),
        ],
        child: Container(
          width: mediaQuery.size.width,
          decoration: BoxDecoration(
            color: lighterGreyColor,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  height: mediaQuery.size.height * 0.09,
                  width: mediaQuery.size.height * 0.13,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      Constants.URL + imageUrl,
                      fit: BoxFit.fill,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  title,
                  style: kTextHeading2,
                ),
                Spacer(),
                //fixme: uncomment this to shoe quantity
                /*Text(
                  quantity,
                  style: TextStyle(
                      color: mediumGreyColor1,
                      fontSize: 16,
                      fontFamily: 'Acumin'),
                ),*/
                SizedBox(
                  width: 8,
                ),
                Text(
                  '\$ $price',
                  style: TextStyle(
                      color: mediumGreyColor2,
                      fontSize: 16,
                      fontFamily: 'Acumin'),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
