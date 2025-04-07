import 'package:cash_agent_admin/app/constant/button.dart';
import 'package:cash_agent_admin/app/modules/addNotice/views/add_notice_view.dart';
import 'package:cash_agent_admin/app/modules/company/views/company_view.dart';
import 'package:cash_agent_admin/app/modules/condition/views/condition_view.dart';
import 'package:cash_agent_admin/app/modules/deposit/views/deposit_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HomeView'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 15,
          children: [
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconElevatedButton(
                  title: 'Add Notice',
                  icon: Icons.notifications,
                  color: Get.theme.primaryColor,
                  onPressed: () {
                    Get.to(AddNoticeView());
                  },
                ),
                IconElevatedButton(
                  title: 'Add Conditions',
                  icon: Icons.rule,
                  color: Get.theme.primaryColor,
                  onPressed: () {
                    Get.to(ConditionView());
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconElevatedButton(
                  title: 'Deposit',
                  icon: Icons.account_balance_wallet,
                  color: Get.theme.primaryColor,
                  onPressed: () {
                    Get.to(DepositView());
                  },
                ),
                IconElevatedButton(
                  title: 'Withdraw',
                  icon: Icons.money_off,
                  color: Get.theme.primaryColor,
                  onPressed: () {},
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconElevatedButton(
                  title: 'Company',
                  icon: Icons.business,
                  color: Get.theme.primaryColor,
                  onPressed: () {
                    Get.to(CompanyView());
                  },
                ),
                IconElevatedButton(
                  title: 'Payment Method',
                  icon: Icons.payment,
                  color: Get.theme.primaryColor,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
