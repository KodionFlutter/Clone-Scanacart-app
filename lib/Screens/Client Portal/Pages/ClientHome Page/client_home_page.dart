import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/ClientHome%20Page/controller/clienthome_controller.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/drawer_widget.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/pop_menu_widget.dart';

class ClientHomePage extends StatelessWidget {
  ClientHomePage({super.key});

  final clientHomePageController = Get.put(
    ClientHomeController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: clientHomePageController.scaffoldKey,
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.txtWhiteColor,
        elevation: 2,
        centerTitle: true,
        title: Obx(() => Text(
              clientHomePageController.titleName.value,
            )),
        actions: [
          PopMenuWidget(
            productName: 'Product Name',
            productImage: clientHomePageController.imageUrl.value,
            onTap: () {
              clientHomePageController.selectedIndex.value = 99;
              clientHomePageController.titleName.value = "My Profile";
              // Get.back();
            },
          )
        ],
      ),
      drawer: DrawerWidget(),
      body: Obx(() => clientHomePageController.getPages(
            clientHomePageController.selectedIndex.value,
          )),
    );
  }
}