import 'package:get/get.dart';
import 'package:scan_cart_clone/Utils/DataBase%20helper/data_base_helper.dart';

class CartController extends GetxController {
//! Declare the variable ..

  var itemLength = 0.obs;
  var items = [].obs;
  var cartItems = [].obs;
  var currentClientID;
  var currentQuantity = 0.obs;

  @override
  void onInit() {
    refreshItems();
    super.onInit();
  }

//! Here fetch the cart Item ..
  Future refreshItems() async {
    items.value = await DataBaseHelper.dataBaseHelper.fetchProduct();
    print('CartItem : $items');
    itemLength.value = items.length;
    print("Item Length :: ${itemLength}");
    currentClientID = items[0]['client_id'];
    print('Client ID --: $currentClientID');
    cartItems.assignAll(items);
    // update();
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
    refreshItems();
  }

  // Method to decrease quantity of an item
  Future<void> decreaseQuantity(
      id,variants) async {
    var cartDataList = await DataBaseHelper.dataBaseHelper.fetchProduct();

    var currentItem = cartDataList.firstWhere((item) =>
        (item['id'] == id) &&
        item['variants'] == variants);

    currentQuantity.value = currentItem['quantity'];
    print("yyyyyy => $currentQuantity");
    if (currentQuantity.value > 1) {
      await DataBaseHelper.dataBaseHelper
          .updateProductQuantity(id, -1, variants);
      refreshItems();
    } else {
      print('Cannot decrease quantity further.');
    }
    //  if(number> 1){
    //    await DataBaseHelper.dataBaseHelper
    //        .updateProductQuantity(id, -1, productColor, productSize);
    //    refreshItems();
    //  }else{
    //    print('Cannot decrease quantity further.');
    //  }
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

// getColor(ImageProvider imagePath) async {
//   var d = await PaletteGenerator.fromImageProvider(imagePath);
//   final palette = d.dominantColor?.color;
//   print("p ::$palette");
// }
}
