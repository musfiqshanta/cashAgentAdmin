import 'package:cash_agent_admin/app/constant/color.dart';
import 'package:cash_agent_admin/app/constant/custom_text.dart';
import 'package:cash_agent_admin/app/constant/text_field.dart';
import 'package:cash_agent_admin/app/modules/addNotice/controllers/add_notice_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNotice extends GetView<AddNoticeController> {
  const AddNotice({super.key});
  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final addNoticeController = Get.put(AddNoticeController());
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
            textField(
              titleController: titleController,
              hints: 'Notice Title',
              label: "Notice Title",
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(Get.width, 50),
                shape: RoundedRectangleBorder(
                  // Use RoundedRectangleBorder instead of OutlineInputBorder
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
                if (titleController.text.isEmpty) {
                  Get.snackbar(
                    'Error',
                    'Title empty',
                    duration: Duration(seconds: 3),
                    backgroundColor: red,
                  );
                  return;
                }
                addNoticeController.addNotice(titleController.text);
              },
              child: text(title: 'Add Notice', color: black),
            ),
          ],
        ),
      ),
    );
  }
}
