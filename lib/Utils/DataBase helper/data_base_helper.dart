import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:developer' as developer;

class DataBaseHelper {
  static const id = "id";
  static const clientId = "client_id";
  static const productId = "productId";
  static const productQuantity = "quantity";
  static const productPoints = "points";
  static const productTitle = "productName";
  static const productImage = "imageURL";
  static const categoryId = "category_id";
  static const variantId = "variantId";
  static const variants = "variants";

  //! Create a map variants
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
            $id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            $clientId INTEGER,
            $productId INTEGER,
            $productQuantity INTEGER,
            $productPoints INTEGER,
            $variantId INTEGER, 
            $categoryId TEXT,
            $productTitle TEXT,          
            $productImage TEXT,
            $variants TEXT
            )''');
  }

  //! Insert Query
  Future insert(Map<String, dynamic> addCartData) async {
    var database = await dataBaseHelper.getDatabase;
    //! Checking for productList Empty or Not..
    List<Map<String, dynamic>> productCartRecords =
        await database.query(_tableName);
    print("This is into Db length is : ${productCartRecords.length}");
    // Check if record isNotEmpty .
    if (productCartRecords.length > 0 && productCartRecords.isNotEmpty) {
      print("No empty");
      //! Here if same client is...
      List<Map<String, dynamic>> cartRecords = await database.query(
        'ProductCart',
        // where: '$productId = ? AND $variants = ?',
        where: '$productId = ?',
        whereArgs: [
          addCartData[productId],
          // addCartData[variants],
        ],
        limit: 1,
      );
      print("Matching product :: $cartRecords}");
      List<Map<String, dynamic>> existingProducts = await database.query(
        _tableName,
        where: '$productId = ? AND $variants = ?',
        whereArgs: [
          addCartData[productId],
          addCartData['variants'].toString(),
        ],
      );

      if (existingProducts.isNotEmpty) {
        // Product with the same variant exists, update its quantity
        int newQuantity = existingProducts[0][productQuantity] + 1;
        await database.update(
          _tableName,
          {productQuantity: newQuantity},
          where: '$productId = ? AND $variants = ?',
          whereArgs: [
            addCartData[productId],
            addCartData['variants'].toString(),
          ],
        );
      } else {
        // Insert as a new entry
        await database.insert(_tableName, addCartData);
      }
    } else {
      print("yes empty");
      // Database has no records
      await database.insert(_tableName, addCartData);
      print('ProductCart database is empty!');
    }
  }

  //! Insert Query
  // Future insert(Map<String, dynamic> addCartData) async {
  //   var database = await dataBaseHelper.getDatabase;
  //
  //   // Check if the same product with the same variants exists
  //
  // }

  //! Fetch The Product Data..
  Future fetchProduct() async {
    var database = await dataBaseHelper.getDatabase;
    List<Map<String, dynamic>> cartDataList = await database.query(_tableName);
    developer.log(cartDataList.toString());
    return cartDataList;
  }

//! Delete the Use Details from DB
  Future deleteCartOneData(id) async {
    var db = await dataBaseHelper.getDatabase;
    return db.delete(_tableName, where: "id = ? ", whereArgs: [id]);
  }

  //! Update the productQuantity , if they add want to add more quantity of the product ..
  Future<void> updateProductQuantity(id, quantity, variants) async {
    final db = await dataBaseHelper.getDatabase;
    await db.rawUpdate(
        'UPDATE $_tableName SET $productQuantity = quantity + ? WHERE  id = ? AND variants = ?',
        [quantity, id, variants]);
  }

  //! Delete  the DataBase..

  Future<void> deleteAllData() async {
    var db = await dataBaseHelper.getDatabase;
    await db.delete(_tableName);
  }
}