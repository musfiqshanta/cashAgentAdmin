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
              final title = data.docs[index]['title'];
              final ma = data.docs[index]['minimumAmount'].toString();
              final sc = data.docs[index]['serviceCharge'].toString();
              final wn = data.docs[index]['phone'].toString();
              final pos = data.docs[index]['index'].toString();
              final id =data.docs[index].id;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: () {
                    Get.to(
                      AddPaymentMethod(
                        title: title,
                        ma: ma,
                        sc: sc,
                        wn: wn,
                        po: pos,
                        id: id,
                      ),
                    );
                  },
                  leading: Icon(Icons.payment, size: 40, color: Colors.white),
                  title: text(title: title),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      text(title: "Minimum : $ma tk"),
                      text(title: "Service : $sc tk"),
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
