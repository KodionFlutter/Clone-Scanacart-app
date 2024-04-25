import 'package:get/get.dart';
import 'package:scan_cart_clone/Utils/DataBase%20helper/data_base_helper.dart';

class CartController extends GetxController {
//! Declare the variable ..

  late dynamic getDataList = [].obs;
  dynamic items = [].obs;
  RxInt totalProduct = 1.obs;

  @override
  void onInit() {
    getCartData();
    super.onInit();
  }

//! Here fetch the cart Item ..

  Future getCartData() async {
    DataBaseHelper helper = DataBaseHelper.dataBaseHelper;
    getDataList = helper.fetchUser();
    items = getDataList;

    print("List of cart Data :: ${getDataList}");
    update();
  }

  Future<void> deleteProduct(productId) async {
    DataBaseHelper helper = DataBaseHelper.dataBaseHelper;
    helper.deleteCartOneData(productId).then((value) {
      items = getDataList;
      update();
    });
  }

  //! Add more product button ..
  addMoreProduct() {
    totalProduct.value += 1;
  }
//! Remove the product..
removeProduct(){
    totalProduct.value -= 1;
}
  var cartItems = [].obs;

  // Method to increase quantity of an item
  void increaseQuantity(int index) {
    cartItems[index]['quantity']++;
  }

  // Method to decrease quantity of an item
  void decreaseQuantity(int index) {
    if (cartItems[index]['quantity'] > 1) {
      cartItems[index]['quantity']--;
    }
  }
}
