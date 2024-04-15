import 'dart:developer';

import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:scan_cart_clone/Models/employee_data_model.dart';
import 'package:video_player/video_player.dart';

class ProductController extends GetxController {
  EmployeeDataModel responseData;
  var serialNumber;

  ProductController({
    required this.responseData,
    this.serialNumber,
  });

  //! Declare the Variable.

  RxBool isPopupVisible = false.obs;
  RxString logoPath = ''.obs;
  RxString productUrl = ''.obs;
  RxString clientName = ''.obs;
  RxString clientUrl = ''.obs;
  RxString clientId = ''.obs;
  RxString videoUrl = ''.obs;
  RxList productImages = [].obs;
  RxInt rewardPoint = 0.obs;
  late VideoPlayerController videoPlayerController;

  @override
  void onInit() {
    Future.delayed(Duration.zero).then((value) => initializationVariable());
    super.onInit();
    if(responseData.videoUrl!.endsWith("mp4")){
      videoInitliz();
    }
    showPopUp();
  }

  @override
  void dispose() {
    videoPlayerController.pause();
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  void onClose() {
    videoPlayerController.pause();
    super.onClose();
  }

// Initialization the  values
  void initializationVariable() {
    logoPath.value = responseData.logoPath!;
    print("Response logo path :: ${responseData.logoPath!}");
    videoUrl.value = responseData.videoUrl!;
    clientName.value = responseData.client!;
    rewardPoint.value = responseData.rewards!;
    clientUrl.value = responseData.clientURL!;
    print("${rewardPoint.value}");
    print(videoUrl.value);
    update();
  }

//{"rewards":125,"productImages":[],"activity_loc_id":"","itemImage":"","large_logo":"logo.png","shipTo":"","activity_id":"","client":"BB Simon","logo_path":"https://dev.scanacart.com/assets/img/logo/bbsimon.png","rewards_active":1,"code":"","serial_num":46693523,"video_url":"https://www.scanacart.com/assets/video/buzzbar.mp4","client_id":1966,"label_password_id":88948007,"is_360":0,"getAllClientLabResults":"","clientURL":"https://www.verifybbsimon.com/verify/","itemName":""}

  // Make a function for Hide PopUp
  void hidePopUp() {
    isPopupVisible.value = false;
  }

  // Make a function to show the PopUp
  void showPopUp() {
    isPopupVisible.value = true;
  }

  // Make a video play controller
  void videoInitliz() async {
    log("This is Video URL :: ${videoUrl.value}");
    videoPlayerController =
        await VideoPlayerController.networkUrl(Uri.parse(videoUrl.value))
          ..initialize().then((v) {
            videoPlayerController.play();
            videoPlayerController.setLooping(true);
          });
    update();
  }
}
