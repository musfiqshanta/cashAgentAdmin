import 'package:cash_agent_admin/app/constant/custom_text.dart';
import 'package:cash_agent_admin/app/constant/general_widget.dart';
import 'package:cash_agent_admin/app/modules/paymentMethod/views/add_payment_method.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/payment_method_controller.dart';

class PaymentMethodView extends GetView<PaymentMethodController> {
  const PaymentMethodView({super.key});
  @override
  Widget build(BuildContext context) {
    final paymentMethod = FirebaseFirestore.instance.collection(
      'paymentMethod',
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Method'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(AddPaymentMethod());
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: paymentMethod.orderBy('index', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return loading;
          }
          final data = snapshot.data;
          return ListView.builder(
            itemCount: data!.docs.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onLongPress: () {
                    Get.snackbar('title', 'on long press');
                  },
                  leading: Image.asset('assets/img/upay.png'),
                  title: text(title: data.docs[index]['title']),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      text(
                        title:
                            "Minimum : ${data.docs[index]['minimumAmount'].toString()} tk",
                      ),
                      text(
                        title:
                            "Service : ${data.docs[index]['serviceCharge'].toString()} tk",
                      ),
                    ],
                  ),
                ),
              );
              // return Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: text(title: data.docs[index]['title']),
              // );
            },
          );
        },
      ),
    );
  }
}
