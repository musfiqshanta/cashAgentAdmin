import 'package:cash_agent_admin/app/modules/condition/views/condition.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/condition_controller.dart';

class ConditionView extends GetView<ConditionController> {
  const ConditionView({super.key});
  @override
  Widget build(BuildContext context) {
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
      body: const Center(
        child: Text('ConditionView is working', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
