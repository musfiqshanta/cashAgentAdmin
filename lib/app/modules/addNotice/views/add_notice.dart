import 'package:cash_agent_admin/app/constant/color.dart';
import 'package:cash_agent_admin/app/constant/custom_text.dart';
import 'package:cash_agent_admin/app/constant/text_field.dart';
import 'package:cash_agent_admin/app/modules/addNotice/controllers/add_notice_controller.dart';
import 'package:cash_agent_admin/app/modules/condition/views/condition.dart'
    show AddCondition;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNotice extends GetView<AddNoticeController> {
  const AddNotice({super.key});
  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Notice'),
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
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          spacing: 20,
          children: [
            SizedBox(height: 10),
            textField(titleController),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(Get.width, 50),
                shape: RoundedRectangleBorder(
                  // Use RoundedRectangleBorder instead of OutlineInputBorder
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {},
              child: text(title: 'Add Notice', color: black),
            ),
          ],
        ),
      ),
    );
  }
}
