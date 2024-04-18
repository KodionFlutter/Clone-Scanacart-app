import 'package:get/get.dart';
import 'package:scan_cart_clone/Models/category_model.dart';
import 'package:scan_cart_clone/Utils/Base%20service/services.dart';

class CategoryController extends GetxController {
  final int clientId;

  CategoryController({required this.clientId});

  //! Variable dec
  // List<Data> categoryList = [];
  var categoryList= <Data>[].obs;
  CategoryModel categoryModel = CategoryModel();

  //!
  Future getProductCategory() async {
    categoryModel = await APIServices.hitProductCategory(clientId);
    categoryList.addAll(categoryModel.data!);
    print("This is category List :: ${categoryList}");
    print("Image path :: ${categoryList[0].categoryImage!}");
    update();
  }

  @override
  void onInit() {
    getProductCategory();
    super.onInit();
  }
}
