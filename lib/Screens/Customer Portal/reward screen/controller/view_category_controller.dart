import 'package:get/get.dart';
import 'package:scan_cart_clone/Models/view_category_model.dart';
import 'package:scan_cart_clone/Utils/Base%20service/services.dart';

class ViewCategoryController extends GetxController {
  final int categoryId;
  final int clientId;

  ViewCategoryController({ required this.categoryId, required this.clientId,});

  var viewCategoryList = [].obs;
  ViewCategoryModel viewCategoryModel = ViewCategoryModel();


  //! GetView Category

  Future getViewCategory() async {
    viewCategoryModel = await APIServices.hitViewCategory(categoryId, clientId);
    viewCategoryList.addAll(viewCategoryModel as Iterable);
    print("View category List == ${viewCategoryList}");
  }


  @override
  void onInit() {
    getViewCategory();
    super.onInit();
  }
}