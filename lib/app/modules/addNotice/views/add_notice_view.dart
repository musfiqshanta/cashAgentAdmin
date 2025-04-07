import 'package:cash_agent_admin/app/modules/addNotice/views/add_notice.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_notice_controller.dart';

class AddNoticeView extends GetView<AddNoticeController> {
  const AddNoticeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notice'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(AddNotice());
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: const Center(
        child: Text('Add Notice View is working', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
