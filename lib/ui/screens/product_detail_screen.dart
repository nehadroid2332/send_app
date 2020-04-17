import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sendapp/model/product.dart';
import 'package:sendapp/services/cart_repo.dart';
import 'package:sendapp/utils/constants.dart';

class ProductDetail extends StatefulWidget {
  final Product product;
  final bool notFromCart;

  ProductDetail({@required this.product,this.notFromCart = true});

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
int i = 1;
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          '${widget.product.name}',
          style: kTextHeading,
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            CupertinoIcons.back,
            color: greenColor,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: whiteColor,
//        border: Border(bottom: BorderSide.none),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //Image
              Container(
                width: mediaQuery.size.width ,
                height: mediaQuery.size.height*0.3,
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.8),
                  child: Image.network(
                    Constants.URL + widget.product.image,
                    width: mediaQuery.size.width * 0.8,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              //Info section
              Container(
                width: mediaQuery.size.width,
                decoration: BoxDecoration(
                  color: lighterGreyColor,
                  borderRadius: BorderRadius.all(Radius.circular(9)),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        widget.product.name,
                        style: kTextHeading2,
                      ),
                      Text(
                        //Todo: Dynamic Pricing
                        "\$${widget.product.price}",
                        style: kTextHeading2,
                      ),

                      Container(
                        decoration: BoxDecoration(
                          color: lightGreyColor,
                          borderRadius: BorderRadius.circular(5.8)
                        ),
                        height: MediaQuery.of(context).size.height*0.055,
                        width: MediaQuery.of(context).size.height*0.139,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            GestureDetector(
                              child: Icon(Icons.remove,color: mediumGreyColor1,),
                              onTap: (){
                                setState(() {
                                  widget.product.cartQuantity==1?null:widget.product.setCartQuantity = -1;
                                });
                              },
                            ),
                            Text("${widget.product.cartQuantity}"),
                            GestureDetector(
                              child: Icon(Icons.add,color: mediumGreyColor2,),
                              onTap: (){
                                setState(() {
                                   if(widget.product.cartQuantity>=widget.product.maxQuantity.toInt()){_scaffoldKey.currentState
                                     ..hideCurrentSnackBar()
                                     ..showSnackBar(
                                       SnackBar(
                                         backgroundColor: greenColor,
                                         content: Text("You Reached Maximum Quantity",style: TextStyle(color: whiteColor),),
                                       ),
                                     );}else  widget.product.setCartQuantity = 1;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: mediaQuery.size.height*0.03,
              ),
              //Button Add to cart
             if(widget.notFromCart) ButtonTheme(
                minWidth: mediaQuery.size.width,
                height: mediaQuery.size.height*0.08,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(36.0),
                      side: BorderSide(color: greenColor, width: 2)),
                  onPressed: () async {
                    String prod = await RepositoryProvider.of<CartRepo>(context)
                        .addProduct(widget.product);
                    _scaffoldKey.currentState
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          backgroundColor: greenColor,
                          content: Text(prod,style: TextStyle(color: whiteColor),),
                        ),
                      );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/icon-add-cart.png',
                          scale: 2.5,
                        ),
                        SizedBox(
                          width: 9,
                        ),
                        Text('ADD TO CART',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                  color: greenColor,
                  textColor: Colors.white,
                  elevation: 1,
                ),
              ),
              SizedBox(
               height: mediaQuery.size.height*0.06,
              ),
              Text(
                'Description',
                style: TextStyle(
                  color: greenColor,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 11,
              ),
              //Todo: Dynamic decription
              Text(
                widget.product.description,
                style: TextStyle(
                  color: mediumGreyColor2,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
