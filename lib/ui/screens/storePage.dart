import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sendapp/bloc/category_bloc/category_bloc.dart';
import 'package:sendapp/bloc/category_bloc/category_event.dart';
import 'package:sendapp/bloc/category_bloc/category_state.dart';
import 'package:sendapp/bloc/product_bloc/bloc.dart';
import 'package:sendapp/model/category.dart';
import 'package:sendapp/ui/screens/products_screen.dart';
import 'package:sendapp/ui/widgets/category_grid_item.dart';
import 'package:sendapp/utils/constants.dart';

class StorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (context) => Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          backgroundColor: whiteColor,
          centerTitle: true,
          elevation: 0,
//          border: Border(bottom: BorderSide.none),
          title: Text(
            "Store",
            style: kTextHeading,
          ),

          actions: <Widget>[
            BlocBuilder<CategoryBloc, CategoryState>(
              bloc: context.bloc<CategoryBloc>(),
              builder: (context, state) {
                if (state is CategoryLoaded) {
                  return IconButton(
                    icon: Image.asset(
                      "assets/icon-search.png",
                      scale: 2.5,
                    ),
                    onPressed: () async {
                      print("pressed");
                      var searchResult = await showSearch<Category>(
                        context: context,
                        delegate: SearchPage(state.categories),
                      );
                      searchResult != null
                          ? Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => ProductBloc()
                                    ..add(LoadProducts(id: searchResult.id)),
                                  child: ProductScreen(
                                    title: searchResult.name,
                                  ),
                                ),
                              ),
                            )
                          : null;
                      print(searchResult);
                    },
                    color: mediumGreyColor2,
                  );
                } else if (state is CategoryLoadingFail) {
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
                        ),
                        );
                    },
                    color: mediumGreyColor2,
                  );
                } else if (state is CategoryLoading) {
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
            /*IconButton(
              icon: Image.asset(
                "assets/icon-search.png",
                scale: 2.5,
              ),
              onPressed: () {
                print("pressed");
                showSearch(
                  context: context,
                  delegate: SearchPage([]),
                );
              },
              color: mediumGreyColor2,
            )*/
          ],
        ),
        body: _buildGridWidget(context),
      ),
//      child: ,
    );
  }

  Widget _buildGridWidget(context) => BlocBuilder(
        bloc: BlocProvider.of<CategoryBloc>(context),
        builder: (ctx, state) {
          print(state);
          if (state is CategoryLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CategoryLoadingFail) {
            return Center(
              child: FlatButton(
                  onPressed: () {
                    print("pressed");
                    BlocProvider.of<CategoryBloc>(context)..add(LoadCategories());
                  },
                  child: Text(
                    "${state.reason}\ntap to refresh",
                    textAlign: TextAlign.center,
                    style: kTextBody,
                  )),
            );
          } else if (state is CategoryLoaded) {
            print(state.props);
            return GridView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: state.categories.length,
              padding: EdgeInsets.only(top: 40, left: 22, right: 22),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .8,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 5),
              itemBuilder: (_, index) {
                return CategoryItem(cat: state.categories[index]);
              },
            );
          }
          return Container();
        },
      );
}

class SearchPage extends SearchDelegate<Category> {
  final List<Category> categoryNames;

  List<String> filterName = new List();

  SearchPage(this.categoryNames)
      : super(
          searchFieldLabel: "Search Categories",
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
        );

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme.copyWith(
      primaryColor: lighterGreyColor,
        inputDecorationTheme: InputDecorationTheme(

      filled: true,
      hintStyle:
          Theme.of(context).textTheme.headline.copyWith(color: mediumGreyColor1,fontWeight: FontWeight.w400),
    ),);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        tooltip: 'Clear',
        icon: const Icon(
          Icons.clear,
          color: Color(0xffef5350)
          ,
        ),
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
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggestions = query.isEmpty
        ? null
        : categoryNames.where((c) => c.name.contains(query)).toList();

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
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? null
        : categoryNames.where((c) => c.name.contains(query)).toList();
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
