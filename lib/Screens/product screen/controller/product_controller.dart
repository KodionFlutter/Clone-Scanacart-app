import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:scan_cart_clone/Models/employee_data_model.dart';
import 'package:scan_cart_clone/Utils/constant.dart';
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
  VideoPlayerController? videoPlayerController;

  @override
  void onInit() {
    Future.delayed(Duration.zero).then((value) => initializationVariable());
    super.onInit();
  }

  @override
  void dispose() {
    videoPlayerController?.pause();
    videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  void onClose() {
    videoPlayerController?.pause();
    super.onClose();
  }

// Initialization the  values
  Future<void> initializationVariable() async{
    try {
      logoPath.value = responseData.logoPath!;
      print("Response logo path :: ${responseData.logoPath!}");
      videoUrl.value = responseData.videoUrl!;
      log("Video url path : ${videoUrl.value}");
      clientName.value = responseData.client!;
      rewardPoint.value = responseData.rewards!;
      clientUrl.value = responseData.clientURL!;
      print("${rewardPoint.value}");
      print(videoUrl.value);
      videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(videoUrl.value));
      await videoPlayerController?.initialize();
      videoPlayerController?.play();
      videoPlayerController?.setLooping(true);

    } catch (e) {
      log("Error initializing video player: $e");
    }
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
  // void videoInitliz() {
  //   log("This is Video URL :: ${videoUrl.value}");
  //
  // }

  ClipRect getBOXFitted(VideoPlayerController _controller) {
    final size = MediaQuery.of(navigatorKey.currentState!.context).size;
    return ClipRect(
        child: SizedBox.expand(
          child: FittedBox(

              fit: BoxFit.fill,
              alignment: Alignment.center,
              child: Container(
                //color: Colors.lightBlue,
                  width: size.width,
                  height: size.height,
                  child: VideoPlayer(_controller))),
        ));
  }
}