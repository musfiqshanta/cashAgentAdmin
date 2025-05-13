import 'package:cash_agent_admin/app/constant/color.dart';
import 'package:cash_agent_admin/app/constant/custom_text.dart';
import 'package:cash_agent_admin/app/constant/general_widget.dart';
import 'package:cash_agent_admin/app/modules/user/views/user_details_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/user_controller.dart';

class UserView extends GetView<UserController> {
  const UserView({super.key});
  @override
  Widget build(BuildContext context) {
    final user = FirebaseFirestore.instance.collection('users');
    final userController = Get.put(UserController());
    return Scaffold(
      appBar: AppBar(title: const Text('User View'), centerTitle: true),
      body: FutureBuilder(
        future: user.get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return loading;
          }
          final data = snapshot.data;
          final length = data!.docs.length;

          return ListView.builder(
            itemCount: length,
            itemBuilder: (context, index) {
              final phone = data.docs[index].id;
              final deposit = data.docs[index]['deposit'].toString();
              final withdraw = data.docs[index]['withdraw'].toString();
              Timestamp join = data.docs[index]['date'];
              DateTime date = join.toDate();
              final formattedTime = DateFormat('dd/MM/yyyy').format(date);

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: () async {
                    await controller.depositRequestsSortedByDate(phone);
                    await controller.withdrawRequestsSortedByDate(phone);
                    Get.to(UserDetailsView());
                  },
                  tileColor: Get.theme.primaryColor,
                  title: text(title: phone),
                  contentPadding: EdgeInsets.all(5),
                  dense: true,
                  isThreeLine: true,
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        spacing: 30,
                        children: [
                          text(title: "📥 $deposit"),

                          text(title: "📤 $withdraw"),
                        ],
                      ),
                      text(title: "Opening date: $formattedTime"),
                    ],
                  ),
                  trailing: StreamBuilder(
                    stream: user.doc(phone).snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return loading;
                      }
                      final data = snapshot.data;
                      late bool promo;
                      try {
                        promo = data!['promo'];
                      } catch (e) {
                        promo = false;
                      }
                      return IconButton(
                        onPressed: () {
                          userController.promoUser(phone, promo);
                        },
                        icon: Icon(Icons.star, color: promo ? red : gray),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
