import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Common/common_services/common_services.dart';
import 'package:scan_cart_clone/Common/widgets/common_scroll_behav_widget.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/ClientHome%20Page/controller/clienthome_controller.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/get_drawer_text.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({super.key});

  final drawerController = Get.put(ClientHomeController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              "Scanacart",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: AppColors.whiteBackgroundColor,
              ),
            ),
            accountEmail: Text(
              "colors@scanacart.com",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.whiteBackgroundColor,
              ),
            ),
            decoration: BoxDecoration(
                // color: Colors.blue,
                gradient: AppColors.verifyLinearGradientColor),
            currentAccountPicture: const Image(
                image: AssetImage("assets/splash/img_splash_anim.gif")),
          ),

          //! 1
          GetDrawerText(
              title: "App Home",
              icon: const Icon(Icons.home_outlined, color: Colors.black),
              onTap: () {
                Get.back();
                Get.back();
              }),

          Flexible(
            child: ScrollConfiguration(
              behavior: CommonScrollBehaveWidget(),
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: drawerMenuList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return index != 4
                        ? GetDrawerText(
                            title: drawerMenuList[index]["name"],
                            icon: drawerMenuList[index]["icon"],
                            onTap: () {
                              drawerController.selectedIndex.value = index;
                              drawerController.titleName.value =
                                  drawerMenuList[index]["name"];
                              if (drawerController
                                  .scaffoldKey.currentState!.isDrawerOpen) {
                                drawerController.scaffoldKey.currentState!
                                    .closeDrawer();
                              }
                              // Get.back();
                            },
                          )
                        : ExpansionTile(
                            leading: drawerMenuList[index]["icon"],
                            enabled: true,
                            // title: GetDrawerText(
                            //   title: drawerMenuList[index]["name"],
                            //   icon: drawerMenuList[index]["icon"],
                            //   onTap: () {
                            //     drawerController.selectedIndex.value = index;
                            //     drawerController.titleName.value =
                            //         drawerMenuList[index]["name"];
                            //     if (drawerController
                            //         .scaffoldKey.currentState!.isDrawerOpen) {
                            //       drawerController.scaffoldKey.currentState!
                            //           .closeDrawer();
                            //     }
                            //   },
                            // ),
                            title: Text(
                              "${drawerMenuList[index]["name"]}",
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            children: [
                              ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: subMenu.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(left: 12.0),
                                      child: GetDrawerText(
                                        title: subMenu[index]["name"],
                                        icon: subMenu[index]["icon"],
                                        onTap: () {
                                          drawerController.selectedIndex.value =
                                              4;
                                          drawerController.subMenuSelectedIndex
                                              .value = index;
                                          print(
                                              "This is SubINdex: ${drawerController.subMenuSelectedIndex.value}");
                                          drawerController.titleName.value =
                                              subMenu[index]["name"];
                                          if (drawerController.scaffoldKey
                                              .currentState!.isDrawerOpen) {
                                            drawerController
                                                .scaffoldKey.currentState!
                                                .closeDrawer();
                                          }
                                        },
                                      ),
                                    );
                                  })
                            ],
                          );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}