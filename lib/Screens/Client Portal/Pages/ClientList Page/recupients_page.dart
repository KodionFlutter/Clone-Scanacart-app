import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Common/App%20Color/app_colors.dart';
import 'package:scan_cart_clone/Common/widgets/common_scroll_behav_widget.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/Pages/ClientList%20Page/controller/recipients_controller.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/common_text_widget.dart';
import 'package:scan_cart_clone/Screens/Client%20Portal/widgets/custom_search_bar_widget.dart';

class RecipientPage extends StatelessWidget {
  RecipientPage({super.key});

  final recipientController = Get.put(RecipientController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteBackgroundColor,
        elevation: 1,
        centerTitle: true,
        title: const Text("Recipients"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {},
              child: CommonTextWidget(
                title: 'Save',
                size: 15,
                color: AppColors.whiteBackgroundColor,
              ),
            ),
          ),
        ],
      ),
      body: ScrollConfiguration(
        behavior: CommonScrollBehaveWidget(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                //! Search bar
                CustomSearchBarWidget(
                    onChanged: () {},
                    controller: recipientController.searchController.value),

                //! Here we Show the Email List ...
                DataTable(
                  showCheckboxColumn: true,
                  showBottomBorder: true,
                  checkboxHorizontalMargin: 10,
                  columns: const [
                    DataColumn(
                      label: Text("Email"),
                    ),
                  ],
                  rows: recipientController.emailList
                      .map(
                        (e) => DataRow(
                            cells: [
                              DataCell(
                                Text("$e"),
                              ),
                            ],
                            // selected: recipientController.emailListIndex[e],
                            onSelectChanged: (value) {
                              // recipientController.emailList[e] = value;
                            }),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}