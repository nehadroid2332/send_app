import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sendapp/bloc/product_bloc/bloc.dart';
import 'package:sendapp/model/product.dart';
import 'package:sendapp/services/cart_repo.dart';
import 'package:sendapp/ui/screens/product_detail_screen.dart';
import 'package:sendapp/utils/constants.dart';

import '../widgets/product_grid_item.dart';

class ProductScreen extends StatelessWidget {
  final String title;
  final String id;

  const ProductScreen({Key key, @required this.title,this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "$title",
          style: kTextHeading,
        ),
        actions: <Widget>[
          BlocBuilder(
            bloc: context.bloc<ProductBloc>(),
            builder: (context, state) {
              if (state is ProductLoaded) {
                return IconButton(
                  icon: Image.asset(
                    "assets/icon-search.png",
                    scale: 2.5,
                  ),
                  onPressed: () async {
                    print("pressed");
                    var searchResult = await showSearch<Product>(
                      context: context,
                      delegate: SearchProduct(state.products),
                    );
                    if (searchResult != null) {
                      var repo = RepositoryProvider.of<CartRepo>(context);
                      Product res = repo.checkProduct(searchResult);
                      res != null
                          ? Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => ProductDetail(
                                    product: searchResult.copyWith(
                                        price: res.price,
                                        carQuantity: res.cartQuantity)),
                              ),
                            )
                          : Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) =>
                                    ProductDetail(product: searchResult),
                              ),
                            );
                    }

                    print(searchResult);
                  },
                  color: mediumGreyColor2,
                );
              } else if (state is ProductLoadingFail) {
                return IconButton(
                  icon: Image.asset(
                    "assets/icon-search.png",
                    scale: 2.5,
                  ),
                  onPressed: () {
                    print("pressed");
                    Scaffold.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(SnackBar(
                        duration: Duration(seconds: 1),
                        content: Text(
                          "No Product For Search",
                          style: TextStyle(color: whiteColor),
                        ),
                        backgroundColor: greenColor,
                      ));
                  },
                  color: mediumGreyColor2,
                );
              } else if (state is ProductLoading) {
                return IconButton(
                  icon: Image.asset(
                    "assets/icon-search.png",
                    scale: 2.5,
                  ),
                  onPressed: () {
                    print("pressed");
                    Scaffold.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text(
                            "No Product For Search",
                            style: TextStyle(color: whiteColor),
                          ),
                          backgroundColor: greenColor,
                        ),
                      );
                  },
                  color: mediumGreyColor2,
                );
              }
              return Container();
            },
          ),
        ],
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            CupertinoIcons.back,
            color: greenColor,
          ),
        ),
      ),
      body: _buildGridWidget(context),
    );
  }

  Widget _buildGridWidget(context) => BlocBuilder(
        bloc: BlocProvider.of<ProductBloc>(context),
        builder: (ctx, state) {
          print(state);
          if (state is ProductLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProductLoadingFail) {
            return Center(
              child: FlatButton(
                  onPressed: () {
                    print("pressed");
                    BlocProvider.of<ProductBloc>(context)..add(LoadProducts(id:id));
                  },
                  child: Text(
                    "${state.reason}\ntap to refresh",
                    textAlign: TextAlign.center,
                    style: kTextBody,
                  )),
            );
          } else if (state is ProductLoaded) {
            print(state.props);
            return GridView.builder(
              padding: EdgeInsets.only(top: 30, left: 22, right: 22),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .8,
                mainAxisSpacing: 10,
                crossAxisSpacing: 5,
              ),
              itemCount: state.products.length,
              itemBuilder: (_, index) {
                return ProductWidget(
                  product: state.products[index],
                );
              },
            );
          }
          return Container();
        },
      );
}

class SearchProduct extends SearchDelegate<Product> {
  final List<Product> productNames;

  List<String> filterName = new List();

  SearchProduct(this.productNames)
      : super(
          searchFieldLabel: "Search Categories",
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
        );

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        tooltip: 'Clear',
        icon: const Icon(Icons.clear, color: Color(0xffef5350)),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          color: greenColor,
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggestions = query.isEmpty
        ? null
        : productNames.where((c) => c.name.contains(query)).toList();

    return GridView.builder(
      itemCount: suggestions == null ? 0 : suggestions.length,
      padding: EdgeInsets.only(top: 40, left: 22, right: 22),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: .8,
          mainAxisSpacing: 10,
          crossAxisSpacing: 5),
      itemBuilder: (_, index) {
        return GestureDetector(
            onTap: () {
              close(context, suggestions[index]);
            },
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
                        padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Image.network(
                            Constants.URL + suggestions[index].image,
                            fit: BoxFit.fill,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.0,
                                  valueColor:
                                      AlwaysStoppedAnimation<Color>(greenColor),
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes
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
                        "${suggestions[index].name}",
                        style: kTextBody,
                      ),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme.copyWith(
      primaryColor: lighterGreyColor,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        hintStyle: Theme.of(context)
            .textTheme
            .headline6
            .copyWith(color: mediumGreyColor1, fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? null
        : productNames.where((c) => c.name.contains(query)).toList();
    return ListView.builder(
      itemCount: suggestions == null ? 0 : suggestions.length,
      itemBuilder: (_, index) => ListTile(
        title: Text(suggestions[index].name),
        onTap: () {
          showResults(context);
        },
      ),
    );
  }
}
