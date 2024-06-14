import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Common/widgets/common_scroll_behav_widget.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/ClientList%20Page/controller/client_list_controller.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/ClientList%20Page/html_editor_page.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/ClientList%20Page/widgets/email_list_widget.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/common_text_widget.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/custom_container.dart';

class ClientListPage extends StatelessWidget {
  ClientListPage({super.key});

  final clientListController = Get.put(ClientListController());

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: CommonScrollBehaveWidget(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            //! Show the Email List ..
            EmailListWidget(),

            //! HtmlEditor..
            CustomContainerWidget(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonTextWidget(
                      title: "Email message",
                      size: 14,
                      color: AppColors.blackBackgroundColor),
                  const SizedBox(height: 10),
                  HtmlEditorPage(
                    htmlEditorController:
                        clientListController.htmlController.value,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: CommonTextWidget(
                          title: 'Submit',
                          size: 14,
                          color: AppColors.whiteBackgroundColor,
                        ),
                      ),
                      SizedBox(width: 15),
                      ElevatedButton(
                        onPressed: () {},
                        child: CommonTextWidget(
                          title: 'Clean',
                          size: 14,
                          color: AppColors.blueColor,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}