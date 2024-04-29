import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:developer' as developer;

class DataBaseHelper {
  static const id = "id";
  static const clientId = "clientId";
  static const productId = "productId";
  static const productQuantity = "productQuantity";
  static const productPoints = "productPoints";
  static const productTitle = "productTitle";
  static const productImage = "productImage";

  static const _tableName = "ProductCart";
  static const _databaseName = "CartDatabase.db";
  static const _databaseVersion = 1;

  //! Here first
  DataBaseHelper._private();

  static final dataBaseHelper = DataBaseHelper._private();
  Database? _database;

  //!  First we get the dataBase..
  Future<Database> get getDatabase async {
    if (_database != null) {
      print("DataBase already exit");
      return _database!;
    } else {
      print("DataBase no exit");
      _database = await initialize();
      return _database!;
    }
  }

  //! Let's initialize the Database

  Future initialize() async {
    print("Database init");
    Directory directory = await getApplicationCacheDirectory();
    var path = join(directory.path, _databaseName);
    developer.log(path.toString());
    _database = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
    return _database;
  }

  //! Create the Database
  Future _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE $_tableName(
            $id INTEGER PRIMARY KEY,
            $clientId INTEGER,
            $productId INTEGER,
            $productQuantity INTEGER,
            $productPoints INTEGER,
            $productTitle TEXT,          
            $productImage TEXT)''');
  }

  //! Insert Query
  Future insert(Map<String, dynamic> addCartData) async {
    var database = await dataBaseHelper.getDatabase;

    //! Checking for productList Empty or Not..
    List<Map<String, dynamic>> productCartRecords = await database.query(
      'ProductCart',
    );
    // Check if record isNotEmpty .
    if (productCartRecords.length > 0) {
      //! Here if same client is...
      List<Map<String, dynamic>> cartRecords = await database.query(
        'ProductCart',
        where: '$productId = ?',
        whereArgs: [addCartData[productId]],
        limit: 1,
      );
      if (cartRecords.isNotEmpty) {
        // Product already exists in the cart, update its quantity in the cartList...
        int newQuantity = cartRecords[0]['productQuantity'] + 1;
        await database.update(
          'ProductCart',
          {'productQuantity': newQuantity},
          where: '$productId = ?',
          whereArgs: [addCartData[productId]],
        );
      } else {
        // Product List in empty , then add into the List..
        await database.insert(_tableName, addCartData);
      }
    } else {
      // Database has no records
      await database.insert(_tableName, addCartData);
      print('ProductCart database is empty!');
    }
  }

  //! Fetch The Product Data..
  Future fetchProduct() async {
    var database = await dataBaseHelper.getDatabase;
    List<Map<String, dynamic>> cartDataList = await database.query(_tableName);
    developer.log(cartDataList.toString());
    return cartDataList;
  }

//! Delete the Use Details from DB
  Future deleteCartOneData(productId) async {
    var db = await dataBaseHelper.getDatabase;
    return await db
        .delete(_tableName, where: "productId = ? ", whereArgs: [productId]);
  }

  //! Update the productQuantity , if they add want to add more quantity of the product ..
  Future<void> updateProductQuantity(productId, quantity) async {
    final db = await dataBaseHelper.getDatabase;
    await db.rawUpdate(
        'UPDATE $_tableName SET $productQuantity = productQuantity + ? WHERE  productId = ?',
        [quantity, productId]);
  }
}
