import 'package:flutter/material.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Common/widgets/common_scroll_behav_widget.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/Dashboard%20Page/widgets/label_validation_location_widget.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/Dashboard%20Page/widgets/label_validation_widget.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/Dashboard%20Page/widgets/serial_validation_verified_widget.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/common_mail_listtile_widget.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/custom_container.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/custom_icon_widget.dart';
import 'package:scan_cart_clone/Utils/constant.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  TabController? tabController;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: CommonScrollBehaveWidget(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            //! Product Logo ..
            CustomContainerWidget(
              child: Image(
                height: AppConstant.size.height * 0.25,
                width: AppConstant.size.width,
                fit: BoxFit.cover,
                // image: NetworkImage(
                //   "https://www.roblaceyphotographer.co.uk/wp-content/uploads/2020/03/featured.jpg",
                // ),
                image: AssetImage("assets/images/blkat.png"),
              ),
            ),

            //! Most Recent Emails ...
            CustomContainerWidget(
                child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Most Recent Emails",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    CustomIconWidget(
                        margin: 0, padding: 8, icon: Icons.mail, iconSize: 18)
                  ],
                ),
                Divider(
                    thickness: 1,
                    color: AppColors.blackBackgroundColor.withOpacity(0.5)),

                //! Show the List of recent mails...
                SizedBox(
                  height: 350,
                  width: double.maxFinite,
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return CommonMailListTileWidget(
                          txtTitle: 'shivam.flutter01@gmai.com',
                          txtSubTitle: const Text(
                            "1 days ago",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w400),
                          ),
                          colors: Colors.red,
                        );
                      }),
                ),
              ],
            )),

            //! Here Social Media Click Thru ...

            CustomContainerWidget(
                child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "social Media Click Thru",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    CustomIconWidget(
                        margin: 0, padding: 8, icon: Icons.share, iconSize: 18)
                  ],
                ),
                Divider(
                    thickness: 1,
                    color: AppColors.blackBackgroundColor.withOpacity(0.5)),
                Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        radius: 15,
                        backgroundColor: AppColors.transparentColor,
                        child: const Image(
                          image: AssetImage("assets/images/instagram.png"),
                        ),
                      ),
                      title: const Text(
                        "Instagram",
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                      trailing: Text(
                        "4",
                        style: TextStyle(color: AppColors.blueColor),
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: AppColors.greyBackgroundColor,
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        radius: 15,
                        backgroundColor: AppColors.transparentColor,
                        child: const Image(
                          image: AssetImage("assets/images/snapchat.png"),
                        ),
                      ),
                      title: const Text(
                        "Snapchat",
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                      trailing: Text(
                        "2357",
                        style: TextStyle(color: AppColors.blueColor),
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: AppColors.greyBackgroundColor,
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        radius: 15,
                        backgroundColor: AppColors.transparentColor,
                        child: const Image(
                          image: AssetImage("assets/images/website.png"),
                        ),
                      ),
                      title: const Text(
                        "Web Site",
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                      trailing: Text(
                        "4",
                        style: TextStyle(color: AppColors.blueColor),
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: AppColors.greyBackgroundColor,
                    ),
                    const SizedBox(height: 25),
                  ],
                )
              ],
            )),

            //! Label Validations...
            LabelValidationWidget(),
            // DefaultTabController(
            //   length: 2,
            //   child: CustomContainerWidget(
            //       child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text("Label Validations",
            //           style:
            //               TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            //       //! Tabs..
            //       TabBar(
            //         dividerColor: AppColors.transparentColor,
            //         padding: EdgeInsets.zero,
            //         automaticIndicatorColorAdjustment: false,
            //         tabs: [
            //           Tab(
            //             text: "tab1",
            //           ),
            //           Tab(
            //             text: "tab2",
            //           ),
            //         ],
            //       ),
            //       Container(
            //         height: 200,
            //         width: double.maxFinite,
            //         child: TabBarView(
            //           controller: tabController,
            //           children: [
            //             Center(
            //               child: Icon(Icons.home),
            //             ),
            //             Center(
            //               child: Icon(Icons.account_circle),
            //             ),
            //           ],
            //         ),
            //       )
            //     ],
            //   )),
            // ),

            //!Serial Validation Verified
            SerialValidationVerified(),
            //! Label Validation Location ..
            LabelValidationLocationWidget()
          ],
        ),
      ),
    );
  }
}