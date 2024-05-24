import 'package:get/get.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:scan_cart_clone/Utils/DataBase%20helper/data_base_helper.dart';

class CartController extends GetxController {
//! Declare the variable ..

  var items = [].obs;
  var cartItems = [].obs;
  var currentQuantity = 0.obs;
  RxBool isLoading = false.obs;
  var colorList = ''.obs;
  var sizeList = ''.obs;
  RxString size = ''.obs;

  var sameClient = 0.obs;
  var colorsList = <PaletteColor>[].obs;
  RxBool isImageLoading = false.obs;

  @override
  void onInit() {
    refreshCartItems();
    super.onInit();
  }

// Here we make the update the palette

//! Here fetch the cart Item ..
  Future refreshCartItems() async {
    // items.clear();
    items.value = await DataBaseHelper.dataBaseHelper.fetchProduct();
    if (items.length > 0) {
      // isLoading.value = true;
      print('CartItem : $items');
      cartItems.assignAll(items);
      isLoading.value = false;
      totalQuantity;
      sameClient.value = items[0]['client_id'];
    } else {
      isLoading.value = false;
    }
  }


  // RxInt totalQuantity = 0.obs;
  num get totalQuantity {
    num total = 0;
    for (var item in cartItems) {
      print("Total ==> ${item['quantity']}");
      total += item['quantity'] ?? 0;
    }

    print("Total : ${total}");
    return total; // Ensure total is not null
  }

  num get totalPoints {
    num total = 0;
    for (var item in cartItems) {
      total += item['quantity'] * item['points'];
    }
    return total;
  }

  // Method to increase quantity of an item
  Future<void> increaseQuantity(id, variants) async {
    print("increase the value");
    await DataBaseHelper.dataBaseHelper.updateProductQuantity(id, 1, variants);
    refreshCartItems();
  }

  // Method to decrease quantity of an item
  Future<void> decreaseQuantity(id, variants) async {
    var cartDataList = await DataBaseHelper.dataBaseHelper.fetchProduct();

    var currentItem = cartDataList.firstWhere(
        (item) => (item['id'] == id) && item['variants'] == variants);

    currentQuantity.value = currentItem['quantity'];
    print("yyyyyy => $currentQuantity");
    if (currentQuantity.value > 1) {
      await DataBaseHelper.dataBaseHelper
          .updateProductQuantity(id, -1, variants);
      refreshCartItems();
    } else {
      print('Cannot decrease quantity further.');
    }
  }

  Future deleteProductData(id) async {
    try {
      await DataBaseHelper.dataBaseHelper.deleteCartOneData(id);
      items.value = await DataBaseHelper.dataBaseHelper.fetchProduct();
      cartItems.assignAll(items);
    } catch (e) {
      print("Error deleting item: $e");
    }
  }
}
