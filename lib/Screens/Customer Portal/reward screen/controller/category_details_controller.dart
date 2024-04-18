import 'package:get/get.dart';
import 'package:scan_cart_clone/Models/category_details_model.dart';
import 'package:scan_cart_clone/Utils/Base%20service/services.dart';

class CategoryDetailsController extends GetxController {
  final int productId;
  final int clientId;

  CategoryDetailsController({
    required this.productId,
    required this.clientId,
  });

  //! Variable declare
  CategoryDetailsModel categoryDetailsModel = CategoryDetailsModel();
  var deatilsImageList = <Images>[].obs;
  RxInt currentImageIndex = 0.obs;

  //! Make a function  to get CategoryDetails
  Future<void> getCategoryDetails() async {
    try {
      categoryDetailsModel =
          await APIServices.hitCategoryDetails(clientId, productId);
      deatilsImageList.addAll(categoryDetailsModel.data!.images);

      // print("L = ${data.toString()}");
      print("List :: => ${categoryDetailsModel.data?.clientId}");
      // }
    } catch (error) {
      "Exception :: ${error.toString()}";
    }
  }

  @override
  void onInit() {
    getCategoryDetails();
    super.onInit();
  }
}
