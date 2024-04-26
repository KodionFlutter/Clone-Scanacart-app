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

  Future<bool> insert(Map<String, dynamic> addCartData) async {
    var database = await dataBaseHelper.getDatabase;

    List<Map<String, dynamic>> productCartRecords = await database.query(
      'ProductCart',
    );

    // Check if a record with the same client ID already exists
    List<Map<String, dynamic>> existingRecords = await database.query(
      _tableName,
      where: '$clientId = ?',
      whereArgs: [addCartData[clientId]],
      limit: 1, //limit i want to check product exit.
    );

    if (productCartRecords.length > 0) {
      if (existingRecords[0]['clientId'] == addCartData['clientId']) {
        // await database.insert(_tableName, addCartData);
        // return true;
        List<Map<String, dynamic>> cartRecords = await database.query(
          'ProductCart',
          where: '$productId = ?',
          whereArgs: [addCartData[productId]],
          limit: 1,
        );
        if (cartRecords.isNotEmpty) {
          // Product already exists in the cart, update its quantity
          int newQuantity = cartRecords[0]['productQuantity'] + 1;
          await database.update(
            'ProductCart',
            {'productQuantity': newQuantity},
            where: '$productId = ?',
            whereArgs: [addCartData[productId]],
          );
          // Product quantity is updated
          return true;
        } else {
          // Product does  not  exist in the cart, insert it into the List
          await database.insert(_tableName, addCartData);
          return true;
        }
      } else {
        return false;
      }
      print('ProductCart database has records!');
    } else {
      // Database has no records
      await database.insert(_tableName, addCartData);
      print('ProductCart database is empty!');
      return true;
    }
  }

  //! Fetch The Data..
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

  Future<void> updateProductQuantity(String productId, int quantity) async {
    final db = await dataBaseHelper.getDatabase;
    await db.rawUpdate(
        'UPDATE $_tableName SET productQuantity = productQuantity + ? WHERE  productId = ?',
        [quantity, productId]);
  }
}
