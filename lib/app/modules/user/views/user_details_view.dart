import 'package:cash_agent_admin/app/constant/color.dart';
import 'package:cash_agent_admin/app/constant/custom_text.dart';
import 'package:cash_agent_admin/app/constant/general_widget.dart';
import 'package:cash_agent_admin/app/modules/user/controllers/user_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

final userController = Get.put(UserController());

class UserDetailsView extends GetView {
  const UserDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Transition History'),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.pink,
            indicatorSize: TabBarIndicatorSize.label,
            dividerColor: black,
            labelColor: white,
            unselectedLabelColor: gray,
            tabs: const <Widget>[Tab(text: 'Deposit'), Tab(text: "Withdraw")],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[DepositHistory(), WithdrawHistory()],
        ),
      ),
    );
  }
}

class DepositHistory extends StatelessWidget {
  const DepositHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      builder: (controller) {
        return controller.depositHistory.isEmpty
            ? Center(child: loading)
            : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: controller.depositHistory.length,
                itemBuilder: (context, index) {
                  // Step 1: Get the Timestamp
                  Timestamp timestamp =
                      controller.depositHistory[index]['time'];
                  DateTime dateTime = timestamp.toDate();

                  String formattedTime = DateFormat(
                    'dd/MM/yyyy hh:mm a',
                  ).format(dateTime);
                  final assetPath =
                      controller.depositHistory[index]['company']
                          .toString()
                          .toLowerCase();

                  final wallet =
                      controller.depositHistory[index]['walletName']
                          .toString()
                          .toLowerCase();

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
                      leading: SizedBox(
                        width: 90,
                        child:
                            controller.depositHistory[index]['type'] ==
                                    'withdraw'
                                ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    FutureBuilder(
                                      future: controller.assetExists(assetPath),
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
                                            title:
                                                controller
                                                    .depositHistory[index]['company']
                                                    .toString(),
                                            //   .substring(0, 4),
                                            size: 10,
                                          ); // Fallback if SVG not found
                                        }
                                      },
                                    ),
                                    text(title: 'title'),
                                    SvgPicture.asset(
                                      'assets/img/svg/arrow.svg',
                                      width: 20,
                                      colorFilter: const ColorFilter.mode(
                                        Colors.white,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    FutureBuilder(
                                      future: controller.assetExists(wallet),
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
                                            title:
                                                userController
                                                    .depositHistory[index]['walletName']
                                                    .toString(),
                                            //     .substring(0, 4),
                                            size: 10,
                                          ); // Fallback if SVG not found
                                        }
                                      },
                                    ),
                                  ],
                                )
                                : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    FutureBuilder(
                                      future: controller.assetExists(wallet),
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
                                          //  return text(title: 'title');
                                          return text(
                                            title: controller
                                                .depositHistory[index]['walletName']
                                                .toString()
                                                .substring(0, 4),
                                            size: 10,
                                          ); // Fallback if SVG not found
                                        }
                                      },
                                    ),
                                    // SvgPicture.asset(
                                    //   "assets/img/svg/${controller.depositHistory[index]['walletName'].toString().camelCase}.svg",
                                    //   fit: BoxFit.cover,
                                    //   width: 25,
                                    // ),
                                    SvgPicture.asset(
                                      'assets/img/svg/arrow.svg',
                                      width: 20,
                                      colorFilter: const ColorFilter.mode(
                                        Colors.white,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    FutureBuilder(
                                      future: controller.assetExists(assetPath),
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
                                                .depositHistory[index]['company']
                                                .toString()
                                                .substring(0, 4),
                                            size: 10,
                                          ); // Fallback if SVG not found
                                        }
                                      },
                                    ),
                                  ],
                                ),
                      ),
                      title: text(
                        title:
                            controller.depositHistory[index]['walletNumber']
                                .toString(),
                      ),
                      isThreeLine: true,
                      subtitle: text(
                        title: formattedTime,
                        color: gray,
                        size: 14,
                      ),
                      trailing: Column(
                        children: [
                          text(
                            title:
                                "${controller.depositHistory[index]['amount']} ৳",
                          ),
                          controller.depositHistory[index]['approved']
                              ? Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: green,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: text(title: 'Success'),
                              )
                              : Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: text(title: 'Pending'),
                              ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
      },
    );
  }
}

class WithdrawHistory extends StatelessWidget {
  const WithdrawHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      builder: (controller) {
        return controller.withdrawHistory.isEmpty
            ? Center(child: loading)
            : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: controller.withdrawHistory.length,
                itemBuilder: (context, index) {
                  // Step 1: Get the Timestamp
                  Timestamp timestamp =
                      controller.withdrawHistory[index]['time'];
                  DateTime dateTime = timestamp.toDate();

                  String formattedTime = DateFormat(
                    'dd/MM/yyyy hh:mm a',
                  ).format(dateTime);
                  final assetPath =
                      controller.withdrawHistory[index]['company']
                          .toString()
                          .toLowerCase();

                  final wallet =
                      controller.withdrawHistory[index]['walletName']
                          .toString()
                          .toLowerCase();
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
                        //historyController.getCombinedRequestsSortedByDate();
                      },
                      leading: SizedBox(
                        width: 90,
                        child:
                            controller.withdrawHistory[index]['type'] ==
                                    'withdraw'
                                ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    FutureBuilder(
                                      future: controller.assetExists(assetPath),
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
                                                .withdrawHistory[index]['company']
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
                                      future: controller.assetExists(wallet),
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
                                          //  return text(title: 'title');
                                          return text(
                                            title: controller
                                                .withdrawHistory[index]['walletName']
                                                .toString()
                                                .substring(0, 4),
                                            size: 10,
                                          ); // Fallback if SVG not found
                                        }
                                      },
                                    ),
                                    // SvgPicture.asset(
                                    //   "assets/img/svg/${controller.withdrawHistory[index]['walletName'].toString().camelCase}.svg",
                                    //   fit: BoxFit.cover,
                                    //   width: 40,
                                    // ),
                                  ],
                                )
                                : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    FutureBuilder(
                                      future: controller.assetExists(wallet),
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
                                          //  return text(title: 'title');
                                          return text(
                                            title: controller
                                                .withdrawHistory[index]['walletName']
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
                                      future: controller.assetExists(assetPath),
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
                                                .withdrawHistory[index]['company']
                                                .toString()
                                                .substring(0, 4),
                                            size: 10,
                                          ); // Fallback if SVG not found
                                        }
                                      },
                                    ),
                                  ],
                                ),
                      ),
                      title: text(
                        title:
                            "${controller.withdrawHistory[index]['walletNumber'].toString()}",
                      ),
                      isThreeLine: true,
                      subtitle: text(
                        title: formattedTime,
                        color: gray,
                        size: 14,
                      ),
                      trailing: Column(
                        children: [
                          text(
                            title:
                                "${controller.withdrawHistory[index]['amount']} ৳",
                          ),
                          controller.withdrawHistory[index]['approved']
                              ? Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: green,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: text(title: 'Success'),
                              )
                              : Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: text(title: 'Pending'),
                              ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
      },
    );
  }
}
