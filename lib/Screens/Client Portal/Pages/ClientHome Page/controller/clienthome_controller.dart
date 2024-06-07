import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/ClientList%20Page/client_list_page.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/Dashboard%20Page/dashboard_page.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/Maps%20Page/maps_page.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/Orders%20Page/orders_page.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/Profile%20Page/my_profile_page.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/Rewards%20Page/Products%20Page/products_page.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/Rewards%20Page/rewardOrder%20Page/reward_order_page.dart';

class ClientHomeController extends GetxController {
  RxInt selectedIndex = 0.obs;
  RxInt subMenuSelectedIndex = 0.obs;
  RxString titleName = "Dashboard".obs;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  RxString imageUrl =
      "https://www.roblaceyphotographer.co.uk/wp-content/uploads/2020/03/featured.jpg"
          .obs;

//! Here we make a function for dynamic change ....

  getPages(selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return const DashBoardPage();
      case 1:
        return ClientOrdersPage();
      case 2:
        return ClientListPage();
      case 3:
        return const MapsPage();
      case 4:
        switch (subMenuSelectedIndex.value) {
          case 0:
            return ProductsPage();
          case 1:
            return RewardOrderPage();
          default:
            return Container();
        }
      case 99:
        return const MyProfilePage();
      default:
        return Container();
    }
  }

  @override
  void onInit() {
    super.onInit();
    getPages(selectedIndex);
  }
}