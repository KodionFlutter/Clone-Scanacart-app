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
  RxInt cunterValue = 0.obs;

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
  RxInt rewardsValue = 0.obs;

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
    // videoPlayerController?.pause();
    super.onClose();
  }

// Initialization the  values
  Future<void> initializationVariable() async {
    try {
      logoPath.value = responseData.logoPath!;
      print("Response logo path :: ${responseData.logoPath!}");

      clientName.value = responseData.client!;
      rewardPoint.value = responseData.rewards!;
      clientUrl.value = responseData.clientURL!;
      videoUrl.value = responseData.videoUrl!;
      rewardsValue.value = responseData.rewards!;
      print("Rewards Data :: $rewardsValue");
      log("Video url path : ${videoUrl.value}");

      //! Playing The Video;
      videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(videoUrl.value));
      print("The Controller of video player == ${videoPlayerController!.value}");
      videoPlayerController?.initialize().then((value) {
        videoPlayerController?.play();
        videoPlayerController?.setLooping(true);
        update();
      });
      update();

      print("${rewardPoint.value}");
      print(videoUrl.value);
    } catch (e) {
      log("Error initializing video player: $e");
    }
    update();
  }

  // Make a function for Hide PopUp
  void hidePopUp() {
    isPopupVisible.value = false;
  }

  // Make a function to show the PopUp
  void showPopUp() {
    isPopupVisible.value = true;
  }

  // Make a video play controller
  void videoInitliz(VideoPlayerController controller) {
    log("This is Video URL :: ${videoUrl.value}");
    // controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl.value));
    // controller.initialize();
    // controller.play();
    // controller.setLooping(true);
    // refresh();
  }

  ClipRect getBOXFitted(VideoPlayerController controller) {
    final size = MediaQuery.of(navigatorKey.currentState!.context).size;
    return ClipRect(
        child: SizedBox.expand(
      child: FittedBox(
          fit: BoxFit.fill,
          alignment: Alignment.center,
          child: SizedBox(
              //color: Colors.lightBlue,
              width: size.width,
              height: size.height,
              child: VideoPlayer(controller))),
    ));
  }
}
