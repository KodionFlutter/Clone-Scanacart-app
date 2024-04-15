import 'package:flutter/material.dart';
import 'package:scan_cart_clone/Utils/constant.dart';
import 'package:video_player/video_player.dart';

class DisplayVideoWidget extends StatelessWidget {
  final VideoPlayerController controller;

  const DisplayVideoWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
        child: SizedBox.expand(
      child: FittedBox(
          fit: BoxFit.fill,
          alignment: Alignment.center,
          child: SizedBox(
              width: AppConstant.size.width,
              height: AppConstant.size.height,
              child: VideoPlayer(controller))),
    ));
  }
}
