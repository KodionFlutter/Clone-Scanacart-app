import 'package:flutter/material.dart';
import 'package:scan_cart_clone/Common/widgets/custom_container.dart';
import 'package:scan_cart_clone/Common/widgets/shimmer_widget.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget(
      child: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CustomContainer(
              height: AppConstant.size.height * 0.3,
              width: AppConstant.size.width ,
              radius: 10,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              // height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: CustomContainer(
                      height: AppConstant.size.height * 0.05,
                      width: AppConstant.size.width * 0.1,
                      radius: 50,
                    ),
                    title: const CustomContainer(
                      height: 10,
                      radius: 20,
                      width: 150,
                    ),
                    subtitle: const CustomContainer(
                      height: 10,
                      radius: 20,
                      width: 150,
                    ),
                    trailing:const CustomContainer(
                      height: 40,
                      radius: 10,
                      width: 90,
                    ),
                  ),
                  CustomContainer(
                    height: 5,
                    radius: 20,
                    width: AppConstant.size.width,
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomContainer(
                        height: 10,
                        radius: 10,
                        width: 120,
                      ),
                      CustomContainer(
                        height: 10,
                        radius: 10,
                        width: 120,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const CustomContainer(
                    height: 40,
                    radius: 10,
                    width: 120,
                  ),
                ],
              ),
            ),
          ),
         Padding(
           padding: const EdgeInsets.all(10.0),
           child: Container(
             decoration: BoxDecoration(
               color: Colors.grey.withOpacity(0.3),
             ),
             child:  ListTile(
               leading: CustomContainer(
                 height: AppConstant.size.height * 0.05,
                 width: AppConstant.size.width * 0.1,
                 radius: 50,
               ),
               title: const CustomContainer(
                 height: 10,
                 radius: 20,
                 width: 150,
               ),
               subtitle: const CustomContainer(
                 height: 10,
                 radius: 20,
                 width: 150,
               ),
               trailing:const CustomContainer(
                 height: 40,
                 radius: 10,
                 width: 90,
               ),
             ),
           ),
         ) ,

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
              ),
              child:  CustomContainer(
                height: 90,
                width: AppConstant.size.width,
                radius: 10,
              )
            ),
          )
        ],
      ),
    );
  }
}
