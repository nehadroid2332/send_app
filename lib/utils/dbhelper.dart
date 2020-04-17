import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sendapp/model/product.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  DatabaseHelper._createInstance();

  String productTable = "product_table";

  final String categoryId = 'categoryId';
  final String id = "id";
  final String name = "name";
  final String productId = "productId";
  final String description = "description";
  final String quantity = "quantity";
  final String maxQuantity = "maxQuantity";
  final String unitPrice = "unitPrice";
  final String status = "status";
  final String cartQuantity = "cartQuantity";
  final String price = "price";
  final String image = "image";

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }


  Future<Database> get database async{
    if(_database == null){
      _database = await initializeDatabase();
    }
    return _database;
  }


 Future<Database> initializeDatabase()async{
    Directory directory =await getApplicationDocumentsDirectory();
    String path = directory.path+"product.db";
    
  var productDatabase = await  openDatabase(path,version: 1,onCreate: _createDatabase );
  return productDatabase;
  }

  void _createDatabase(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $productTable($categoryId TEXT, $id TEXT, $name TEXT, $productId TEXT, $description TEXT, $quantity TEXT, $maxQuantity TEXT,"
            "$unitPrice TEXT, $status TEXT, $cartQuantity TEXT, $price TEXT, $image TEXT)");
  }





  //fetch Operation
Future<List<Product>> getProductsList()async{
    Database db = await  this.database;
    var result = await db.rawQuery('SELECT * FROM $productTable');
    print("get product from db $result");

    return result.map((e) => Product.fromDB(e)).toList();
}
//fetch Operation
Future<void> addProductToDb(Product product)async{
    Database db = await  this.database;
  var result = await db.insert(productTable, product.toJson());
    print("insert from db $result");
//    return result.map((e) => Product.fromJson(e)).toList();
}

  Future<void> updateQuantityAndPrice(
      {String id, String price, String quantity})async {
    Database db = await  this.database;
    var result = await db.rawUpdate("UPDATE product_table SET ${this.price} = ?, ${this.cartQuantity} = ? WHERE ${this.id} = ?",[price,quantity,id]);
//    var result = await db.update(productTable, {this.price:price,this.cartQuantity:quantity},where: "$id = ?", whereArgs:[id] );
  print(result);
  }


//check product in DB
Future<bool> checkProduct(String productId)async{
    Database db = await this.database;
    var result =await  db.rawQuery("SELECT * FROM $productTable WHERE ${this.id} = ?",[productId]);
    print(result);
    return result.isNotEmpty;
}

Future<bool> deleteProduct(String productId)async{
  Database db = await this.database;
  var result =await  db.rawDelete("DELETE  FROM $productTable WHERE ${this.id} = ?",[productId]);
  print(result);
  return true;
}





}
