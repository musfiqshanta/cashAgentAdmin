import 'package:cash_agent_admin/app/constant/color.dart';
import 'package:cash_agent_admin/app/constant/custom_text.dart';
import 'package:cash_agent_admin/app/modules/addNotice/views/add_notice_view.dart';
import 'package:cash_agent_admin/app/modules/company/views/company_view.dart';
import 'package:cash_agent_admin/app/modules/condition/views/condition_view.dart';
import 'package:cash_agent_admin/app/modules/depositWithdraw/controllers/deposit_controller.dart';
import 'package:cash_agent_admin/app/modules/depositWithdraw/views/deposit_view.dart';
import 'package:cash_agent_admin/app/modules/depositWithdraw/views/withdraw.dart';
import 'package:cash_agent_admin/app/modules/options/views/options_view.dart';
import 'package:cash_agent_admin/app/modules/paymentMethod/views/payment_method_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final depositController = Get.put(DepositController());
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
              menuList(
                title: 'Deposit',
                onTap: () async {
                  Get.to(DepositView());
                  await depositController.depositRequestsSortedByDate();
                },
              ),
              menuList(
                title: 'Withdraw',
                onTap: () async {
                  Get.to(WithdrawView());
                  await depositController.withdrawRequestsSortedByDate();
                },
              ),
              menuList(
                title: 'Add Notice',
                onTap: () {
                  Get.to(AddNoticeView());
                },
              ),
              menuList(
                title: 'Add Conditions',
                onTap: () {
                  Get.to(ConditionView());
                },
              ),

              menuList(
                title: 'Company',
                onTap: () {
                  Get.to(CompanyView());
                },
              ),
              menuList(
                title: 'Payment Method',
                onTap: () {
                  Get.to(PaymentMethodView());
                },
              ),
              menuList(
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

  ListTile menuList({required String title, void Function()? onTap}) {
    return ListTile(
      onTap: onTap,

      title: text(title: title),
      leading: Icon(Icons.notifications, color: gray),
      tileColor: Get.theme.primaryColor,
      splashColor: Colors.pink,
    );
  }
}
