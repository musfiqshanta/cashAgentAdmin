import 'package:cash_agent_admin/app/constant/color.dart';
import 'package:cash_agent_admin/app/constant/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/deposit_controller.dart';

class DepositView extends GetView<DepositController> {
  const DepositView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transition History'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              // Adjust margin as needed
              margin: const EdgeInsets.only(top: 10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10), // Rounded bottom-left
                  bottomRight: Radius.circular(10), // Rounded bottom-right
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        'assets/img/svg/bkash.svg',
                        fit: BoxFit.cover,
                        width: 25,
                      ),
                      SvgPicture.asset(
                        'assets/img/svg/arrow.svg',
                        width: 20,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                      SvgPicture.asset(
                        'assets/img/svg/nagad.svg',
                        fit: BoxFit.cover,
                        width: 40,
                      ),
                    ],
                  ),
                ),
                title: text(title: '7716255****'),
                isThreeLine: true,
                subtitle: text(
                  title: '12/05/2024 12:25 PM',
                  color: gray,
                  size: 14,
                ),
                trailing: Column(
                  children: [
                    text(title: '5000 ৳'),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: text(title: 'Success'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
