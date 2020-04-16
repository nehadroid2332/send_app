import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sendapp/bloc/product_bloc/bloc.dart';
import 'package:sendapp/model/category.dart';
import 'package:sendapp/services/categories_repo.dart';
import 'package:sendapp/utils/constants.dart';
import '../screens/products_screen.dart';

class CategoryItem extends StatelessWidget {
  final Category _category;

  const CategoryItem({Key key, @required Category cat})
      : assert(cat != null),
        this._category = cat,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => BlocProvider(
            create: (context) =>
                ProductBloc()..add(LoadProducts(id: _category.id)),
            child: ProductScreen(title: _category.name,id: _category.id,),
          ),
        ),
      ),
      child: Card(
        elevation: 25,
        shadowColor: lighterGreyColor,
        borderOnForeground: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey[200], width: 1),
        ),
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top:15,left: 15,right: 15),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.network(
                      Constants.URL+_category.image,
                      fit: BoxFit.fill,
                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null)
                          return child;
                        return Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                            valueColor: AlwaysStoppedAnimation<Color>(greenColor),
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "${_category.name}",
                  style: kTextBody,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
