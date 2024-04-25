import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
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
      return _database!;
    } else {
      _database = await initalize();
      return _database!;
    }
  }

  //! Let's _initalize the databse

  Future initalize() async {
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
    await db.execute(
        '''CREATE TABLE $_tableName($id INTEGER PRIMARY KEY,$clientId TEXT,$productId TEXT,$productTitle TEXT,$productQuantity TEXT,$productPoints TEXT,$productImage TEXT )''');
  }

  //! Insert Query
  Future insert(Map<String, dynamic> addCartData) async {
    var database = await dataBaseHelper.getDatabase;
    if (kDebugMode) {
      print(addCartData);
      developer.log("Added into Cart :: $database}");
    }

    List<Map<String, dynamic>> result = await database.query(
      '$_tableName',
      where: 'productId = ?',
      whereArgs: [productId],
    );

    List<Map<String, dynamic>> client = await database.query(
      '$_tableName',
      where: 'clientId = ?',
      whereArgs: [clientId],
    );
    if (client == client) {
      if (result.isNotEmpty) {
        // Product already exists, update its quantity
        await updateProductQuantity(productId, int.parse(productQuantity));
      } else {
        // Product doesn't exist, insert it into the database
        return await database.insert(_tableName, addCartData);
      }
    } else {
      return null;
    }
  }

  //! Fetch The Data..
  Future fetchUser() async {
    var database = await dataBaseHelper.getDatabase;
    List cartDataList = await database.query(_tableName);
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
