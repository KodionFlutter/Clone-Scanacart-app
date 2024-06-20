import 'package:flutter/material.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

class CommonHeaderWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback voidCallback;

  const CommonHeaderWidget(
      {super.key,
      required this.title,
      required this.voidCallback,
      this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //! Show the Scanacart Text .

        Padding(
          padding: const EdgeInsets.only(top: 0, right: 8, bottom: 0, left: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 0),
              ),
              const Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 40),
                      child: Text(
                        'Scanacart',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                iconSize: 25,
                icon: const Icon(
                  Icons.cancel_outlined,
                  color: Colors.white,
                ),
                onPressed: voidCallback,
              ),
            ],
          ),
        ),

        //! Scanacart gif Image..
        SizedBox(
          height: AppConstant.size.height * 0.2,
          width: AppConstant.size.width,
          child: Image.asset(
            "assets/splash/img_splash_anim.gif",
            width: 180,
            height: 180,
          ),
        ),

        //! Text here
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
          ),
        ),
         Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            "$subtitle",
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
