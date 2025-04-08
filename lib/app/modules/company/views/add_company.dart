import 'package:cash_agent_admin/app/constant/button.dart';
import 'package:cash_agent_admin/app/constant/color.dart';
import 'package:cash_agent_admin/app/constant/custom_text.dart';
import 'package:cash_agent_admin/app/constant/text_field.dart';
import 'package:cash_agent_admin/app/modules/addNotice/controllers/add_notice_controller.dart';
import 'package:cash_agent_admin/app/modules/company/controllers/company_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCompany extends GetView<AddNoticeController> {
  const AddCompany({super.key});
  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final indexController = TextEditingController();
    final companyController = Get.put(CompanyController());
    return Scaffold(
      appBar: AppBar(title: const Text('Add Company'), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          spacing: 20,
          children: [
            SizedBox(height: 10),
            textField(
              titleController: titleController,
              hints: 'Company Title',
              label: "Company Title",
            ),
            textField(
              titleController: indexController,
              hints: 'Index',
              label: "Position",
              keyboardType: TextInputType.number,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconElevatedButton(
                  icon: Icons.photo,
                  title: 'Upload logo',
                  color: Get.theme.primaryColor,
                  onPressed: () {
                    companyController.pickImage();
                  },
                ),
                Obx(() {
                  final image = companyController.imageFile.value;
                  return image != null
                      ? Image.file(image, height: 50)
                      : text(title: "No image selected.");
                }),
              ],
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
                } else if (indexController.text.isEmpty) {
                  Get.snackbar(
                    'Error',
                    'Add Position',
                    duration: Duration(seconds: 3),
                    backgroundColor: red,
                  );
                }
                companyController.addCompany(
                  titleController.text,
                  int.parse(indexController.text),
                );
              },
              child: text(title: 'Add Notice', color: black),
            ),
          ],
        ),
      ),
    );
  }
}
