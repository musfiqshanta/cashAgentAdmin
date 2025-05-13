import 'package:cash_agent_admin/app/constant/color.dart';
import 'package:cash_agent_admin/app/constant/custom_text.dart';
import 'package:cash_agent_admin/app/constant/general_widget.dart';
import 'package:cash_agent_admin/app/modules/addNotice/views/add_notice_view.dart';
import 'package:cash_agent_admin/app/modules/company/views/company_view.dart';
import 'package:cash_agent_admin/app/modules/condition/views/condition_view.dart';
import 'package:cash_agent_admin/app/modules/depositWithdraw/controllers/deposit_controller.dart';
import 'package:cash_agent_admin/app/modules/depositWithdraw/views/deposit_view.dart';
import 'package:cash_agent_admin/app/modules/depositWithdraw/views/withdraw.dart';
import 'package:cash_agent_admin/app/modules/options/views/options_view.dart';
import 'package:cash_agent_admin/app/modules/paymentMethod/views/payment_method_view.dart';
import 'package:cash_agent_admin/app/modules/user/views/user_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final depositController = Get.put(DepositController());
    final deposit = FirebaseFirestore.instance.collection("depositRequest");
    final withdraw = FirebaseFirestore.instance.collection("withdrawRequest");

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Center(
          child: Image.asset(
            'assets/img/logo.png',
            fit: BoxFit.contain,
            width: 100,
          ),
        ),

        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 15,
            children: [
              SizedBox(height: 10),
              StreamBuilder(
                stream: deposit.where('approved', isEqualTo: false).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return loading;
                  }
                  final data = snapshot.data;
                  final length = data!.docs.length;
                  print(length);

                  return menuList(
                    notification: length.toString(),
                    title: 'Deposit',
                    icon: Icons.account_balance_wallet,
                    onTap: () async {
                      Get.to(DepositView());
                      await depositController.depositRequestsSortedByDate();
                    },
                  );
                },
              ),
              //  text(title: 'title'),
              StreamBuilder(
                stream:
                    withdraw.where('approved', isEqualTo: false).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return loading;
                  }
                  final data = snapshot.data;
                  final length = data!.docs.length;
                  return menuList(
                    notification: length.toString(),
                    icon: Icons.money_off,
                    title: 'Withdraw',
                    onTap: () async {
                      Get.to(WithdrawView());
                      await depositController.withdrawRequestsSortedByDate();
                    },
                  );
                },
              ),
              menuList(
                icon: Icons.account_circle,
                title: 'Users Details',
                onTap: () {
                  Get.to(UserView());
                },
              ),
              menuList(
                icon: Icons.notification_important,
                title: 'Add Notice',
                onTap: () {
                  Get.to(AddNoticeView());
                },
              ),
              menuList(
                icon: Icons.info,
                title: 'Add Conditions',
                onTap: () {
                  Get.to(ConditionView());
                },
              ),

              menuList(
                icon: Icons.receipt_long,
                title: 'Company',
                onTap: () {
                  Get.to(CompanyView());
                },
              ),
              menuList(
                icon: Icons.payment,
                title: 'Payment Method',
                onTap: () {
                  Get.to(PaymentMethodView());
                },
              ),
              menuList(
                icon: Icons.settings,
                title: 'Options',
                onTap: () {
                  Get.to(OptionsView());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListTile menuList({
    required String title,
    notification,
    void Function()? onTap,
    IconData? icon,
  }) {
    return ListTile(
      onTap: onTap,
      trailing:
          notification != null ? text(title: notification) : SizedBox.shrink(),
      title: text(title: title),
      leading: Icon(icon, color: gray),
      tileColor: Get.theme.primaryColor,
      splashColor: Colors.pink,
    );
  }
}
