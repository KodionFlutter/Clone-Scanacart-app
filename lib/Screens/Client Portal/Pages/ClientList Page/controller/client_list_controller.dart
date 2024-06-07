import 'package:get/get.dart';
import 'package:html_editor_enhanced_plus/html_editor.dart';

class ClientListController extends GetxController {
  Rx<HtmlEditorController> htmlController = HtmlEditorController().obs;
}