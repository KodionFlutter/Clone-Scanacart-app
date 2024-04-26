import 'package:get/get.dart';
import 'package:scan_cart_clone/Utils/DataBase%20helper/data_base_helper.dart';

class CartController extends GetxController {
//! Declare the variable ..

  // var cartDataList = [].obs;
  var itemLength = 0.obs;

  @override
  void onInit() {
    // getCartData();
    super.onInit();
  }

//! Here fetch the cart Item ..

  var cartItems = [].obs;

  // Method to increase quantity of an item
  void increaseQuantity(productId, int index) {
    print("incress the value");
    DataBaseHelper.dataBaseHelper.updateProductQuantity(productId, index);
    // cartItems[index]['quantity']++;
  }

  // Method to decrease quantity of an item
  void decreaseQuantity(int index) {}
}
