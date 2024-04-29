import 'package:get/get.dart';
import 'package:scan_cart_clone/Utils/DataBase%20helper/data_base_helper.dart';

class CartController extends GetxController {
//! Declare the variable ..

  var itemLength = 0.obs;
  var items = [].obs;
  var cartItems = [].obs;
  var currentClientID;

  @override
  void onInit() {
    refreshItems();
    super.onInit();
  }

//! Here fetch the cart Item ..

  Future refreshItems() async {
    items.value = await DataBaseHelper.dataBaseHelper.fetchProduct();
    // print('CartItem : $cartItems');
    itemLength.value = items.length;
    currentClientID = items[0]['clientId'];
    print('Client ID --: $currentClientID');
    cartItems.assignAll(items);

    update();
  }

  //! Get the current client
  // getCurrentClient(){
  //   var c =items[0]['id'];
  //   print('c: $c');
  // }

  // RxInt totalQuantity = 0.obs;
  num get totalQuantity {
    num total = 0;
    for (var item in cartItems) {
      total += item['productQuantity'];
    }
    print("Total : ${total}");
    return total; // Ensure total is not null
  }

  num get totalPoints {
    num total = 0;
    for (var item in cartItems) {
      total += item['productQuantity'] * item['productPoints'];
    }
    return total;
  }

  // Method to increase quantity of an item
  Future<void> increaseQuantity(productId) async {
    print("increase the value");
    await DataBaseHelper.dataBaseHelper.updateProductQuantity(productId, 1);
    refreshItems();
  }

  // Method to decrease quantity of an item
  Future decreaseQuantity(productId, int index) async {
    var cartDataList = await DataBaseHelper.dataBaseHelper.fetchProduct();
    var currentItem =
        cartDataList.firstWhere((item) => item['productId'] == productId);
    var currentQuantity = currentItem['productQuantity'];
    if (currentQuantity > 1) {
      await DataBaseHelper.dataBaseHelper.updateProductQuantity(productId, -1);
      refreshItems();
    } else {
      print('Cannot decrease quantity further.');
    }
  }

  void deleteProduct(productId) async {
  await  DataBaseHelper.dataBaseHelper.deleteCartOneData(productId);
    refreshItems();
  }
}
