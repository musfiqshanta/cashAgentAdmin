import 'package:cash_agent_admin/app/constant/custom_text.dart';
import 'package:cash_agent_admin/app/constant/general_widget.dart';
import 'package:cash_agent_admin/app/modules/depositWithdraw/controllers/deposit_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TransitionDetails extends GetView<DepositController> {
  const TransitionDetails({
    super.key,
    required this.id,
    required this.collection,
  });

  final String id, collection;
  @override
  Widget build(BuildContext context) {
    final deposit = FirebaseFirestore.instance.collection(collection).doc(id);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transition Details'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: deposit.get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return loading;
            }
            final data = snapshot.data;
            final amount = data!['amount'];
            final company = data['company'];
            final companyId = data['companyId'];
            final timestamp = data['time']; // Firestore Timestamp
            final dateTime = timestamp.toDate();

            final formatted = DateFormat('dd MM yy - HH : ss').format(dateTime);

            final transitionId = data['transitionId'];
            final walletName = data['walletName'];
            final walletNumber = data['walletNumber'];
            final uId = data['uId'];
            return Column(
              spacing: 10,
              children: [
                listDetails('Amount', amount.toString()),
                listDetails('Company', company),
                listDetails('company Id', companyId),
                listDetails('Transition Id', transitionId),
                listDetails('Wallet Name', walletName),
                listDetails('Wallet Number', walletNumber.toString()),
                listDetails('Time', formatted),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () {
                        controller.transitionAction(
                          id,
                          uId,
                          collection,
                          true,
                          amount,
                        );
                      },
                      child: text(title: "Approved"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () {},
                      child: text(title: "Rejected"),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  ListTile listDetails(String title, value) {
    return ListTile(
      tileColor: Get.theme.primaryColor,
      title: text(title: title),
      trailing: text(title: value),
    );
  }
}
