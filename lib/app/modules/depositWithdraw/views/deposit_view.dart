import 'package:cash_agent_admin/app/constant/color.dart';
import 'package:cash_agent_admin/app/constant/custom_text.dart';
import 'package:cash_agent_admin/app/constant/general_widget.dart';
import 'package:cash_agent_admin/app/modules/depositWithdraw/views/details_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/deposit_controller.dart';

class DepositView extends GetView<DepositController> {
  const DepositView({super.key});
  @override
  Widget build(BuildContext context) {
    final deposit = FirebaseFirestore.instance.collection("depositRequest");
    final depositController = Get.put(DepositController());
    return Scaffold(
      appBar: AppBar(title: const Text('Deposit Request'), centerTitle: true),
      body: FutureBuilder(
        future: deposit.where('approved', isEqualTo: false).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return loading;
          }
          final data = snapshot.data;
          //  final length = data!.docs.length;
          return Obx(() {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: depositController.depositTransition.length,
                itemBuilder: (context, index) {
                  final assetPath =
                      depositController.depositTransition[index]['company']
                          .toString()
                          .toLowerCase();
                  ;
                  final wallet =
                      depositController.depositTransition[index]['walletName']
                          .toString()
                          .toLowerCase();
                  final id = data!.docs[index].id;

                  final phone =
                      depositController
                          .depositTransition[index]['walletNumber'];

                  Timestamp timestamp =
                      depositController.depositTransition[index]['time'];
                  DateTime dateTime = timestamp.toDate();

                  String formattedTime = DateFormat(
                    'dd/MM/yyyy hh:mm a',
                  ).format(dateTime);
                  final amount =
                      depositController.depositTransition[index]['amount'];

                  return Container(
                    // Adjust margin as needed
                    margin: const EdgeInsets.only(top: 10),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10), // Rounded bottom-left
                        bottomRight: Radius.circular(
                          10,
                        ), // Rounded bottom-right
                      ),
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ), // Bottom border
                      ),
                    ),
                    child: ListTile(
                      onTap: () {
                        Get.to(
                          TransitionDetails(
                            id: id,
                            collection: "depositRequest",
                          ),
                        );
                      },
                      leading: SizedBox(
                        width: 90,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // SvgPicture.asset(
                            //   'assets/img/svg/bkash.svg',
                            //   fit: BoxFit.cover,
                            //   width: 25,
                            // ),
                            // SvgPicture.asset(
                            //   'assets/img/svg/arrow.svg',
                            //   width: 20,
                            //   colorFilter: const ColorFilter.mode(
                            //     Colors.white,
                            //     BlendMode.srcIn,
                            //   ),
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FutureBuilder(
                                  future: depositController.assetExists(wallet),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return const SizedBox.shrink();
                                    }
                                    if (snapshot.data == true) {
                                      return SvgPicture.asset(
                                        "assets/img/svg/$wallet.svg",
                                        fit: BoxFit.cover,
                                        width: 25,
                                      );
                                    } else {
                                      return text(
                                        title: controller
                                            .depositTransition[index]['company']
                                            .toString()
                                            .substring(0, 4),
                                        size: 10,
                                      ); // Fallback if SVG not found
                                    }
                                  },
                                ),

                                SvgPicture.asset(
                                  'assets/img/svg/arrow.svg',
                                  width: 20,
                                  colorFilter: const ColorFilter.mode(
                                    Colors.white,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                FutureBuilder(
                                  future: depositController.assetExists(
                                    assetPath,
                                  ),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return const SizedBox.shrink();
                                    }
                                    if (snapshot.data == true) {
                                      return SvgPicture.asset(
                                        "assets/img/svg/$assetPath.svg",
                                        fit: BoxFit.cover,
                                        width: 30,
                                      );
                                    } else {
                                      return text(
                                        title: controller
                                            .depositTransition[index]['company']
                                            .toString()
                                            .substring(0, 4),
                                        size: 10,
                                      ); // Fallback if SVG not found
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      title: text(title: phone.toString()),
                      isThreeLine: true,
                      subtitle: text(
                        title: formattedTime,
                        color: gray,
                        size: 14,
                      ),
                      trailing: Column(children: [text(title: '$amount ৳')]),
                    ),
                  );
                },
              ),
            );
          });
        },
      ),
    );
  }
}
