import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sendapp/bloc/cart_bloc/cart_bloc.dart';
import 'package:sendapp/services/cart_repo.dart';
import 'package:sendapp/services/categories_repo.dart';
import 'package:sendapp/services/user_repo.dart';
import 'package:sendapp/ui/screens/home_screen.dart';
import 'package:sendapp/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
//  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
//  Hive.init(appDocumentDir.path);
  runApp(MyApp());
//  final cart = await Hive.openBox("cart");
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const <LocalizationsDelegate>[
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate
      ],

      theme: ThemeData(
          appBarTheme: AppBarTheme(elevation: 0, color: mediumGreyColor1),
          primaryColor: greenColor,
          primarySwatch: Colors.green),
      //todo: add home page for add flat navigation
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context) => CartRepo()),
          RepositoryProvider(
            create: (context) => CategoriesRepository(),
          ),
          RepositoryProvider(
            create: (context) => UserRepo(),
          ),
        ],
        child:
            BlocProvider(create: (context) => CartBloc(), child: HomeScreen()),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
