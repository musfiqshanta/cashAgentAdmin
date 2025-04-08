import 'package:cash_agent_admin/app/constant/custom_text.dart';
import 'package:cash_agent_admin/app/constant/general_widget.dart';
import 'package:cash_agent_admin/app/modules/condition/views/condition.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/condition_controller.dart';

class ConditionView extends GetView<ConditionController> {
  const ConditionView({super.key});
  @override
  Widget build(BuildContext context) {
    final notice = FirebaseFirestore.instance
        .collection('admin')
        .doc('condition')
        .collection('conditions');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conditions'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(AddCondition());
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: notice.orderBy('time', descending: true).snapshots(),
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
                child: text(title: data.docs[index]['condition']),
              );
            },
          );
        },
      ),
    );
  }
}
