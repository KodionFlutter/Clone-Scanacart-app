import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:scan_cart_clone/Models/view_category_model.dart';
import 'package:scan_cart_clone/Utils/Base%20service/services.dart';

class ViewCategoryController extends GetxController {
  final int categoryId;
  final int clientId;

  ViewCategoryController({
    required this.categoryId,
    required this.clientId,
  });

  var viewCategoryList = <Data>[].obs;
  ViewCategoryModel viewCategoryModel = ViewCategoryModel();
  RxString categoryName = ''.obs;
  RxBool isLoad = false.obs;

  //! GetView Category

  Future getViewCategory() async {
    isLoad.value = true;

    try {
      viewCategoryModel =
          await APIServices.hitViewCategory(categoryId, clientId);
      if (viewCategoryModel.data!.isEmpty) {
        isLoad.value = false;
      } else {
        viewCategoryList.addAll(viewCategoryModel.data!);
        categoryName.value = viewCategoryModel.categoryName!;
        isLoad.value = false;
      }
      // if (viewCategoryModel.data!.isEmpty) {
      //   viewCategoryList.clear();
      // } else {
      // }
      print("View category List == ${viewCategoryList}");
    } catch (e) {
      isLoad.value = false;
      "Exception :: ${e.toString()}";
    }
  }

  @override
  void onInit() {
    getViewCategory();
    super.onInit();
  }
}