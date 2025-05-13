import 'package:cash_agent_admin/app/constant/button.dart';
import 'package:cash_agent_admin/app/constant/color.dart';
import 'package:cash_agent_admin/app/constant/custom_text.dart';
import 'package:cash_agent_admin/app/constant/text_field.dart';
import 'package:cash_agent_admin/app/modules/addNotice/controllers/add_notice_controller.dart';
import 'package:cash_agent_admin/app/modules/company/controllers/company_controller.dart';
import 'package:cash_agent_admin/app/modules/paymentMethod/controllers/payment_method_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPaymentMethod extends GetView<AddNoticeController> {
  const AddPaymentMethod({
    super.key,
    this.title,
    this.ma,
    this.sc,
    this.wn,
    this.po,
    this.id,
  });
  final String? title, ma, sc, wn, po, id;

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: title);
    final indexController = TextEditingController(text: po);
    final minimumAmount = TextEditingController(text: ma);
    final serviceCharge = TextEditingController(text: sc);
    final phoneNumber = TextEditingController(text: wn);
    final companyController = Get.put(CompanyController());
    final paymentMethodController = Get.put(PaymentMethodController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Payment Method'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                titleController: minimumAmount,
                hints: 'Minimum amount',
                label: "Minimum amount",
                keyboardType: TextInputType.number,
              ),
              textField(
                titleController: serviceCharge,
                hints: 'Service charge',
                label: "Service charge",
              ),
              textField(
                titleController: phoneNumber,
                hints: 'Wallet Number',
                label: 'Wallet Number',
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
              id != null
                  ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: red,
                      fixedSize: Size(Get.width, 50),
                      shape: RoundedRectangleBorder(
                        // Use RoundedRectangleBorder instead of OutlineInputBorder
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      paymentMethodController.deletePaymentMethod(id!);
                    },
                    child: text(title: 'Delete payment method'),
                  )
                  : SizedBox.shrink(),
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
                  } else if (minimumAmount.text.isEmpty) {
                    Get.snackbar(
                      'Error',
                      'Add amount',
                      duration: Duration(seconds: 3),
                      backgroundColor: red,
                    );
                  } else if (serviceCharge.text.isEmpty) {
                    Get.snackbar(
                      'Error',
                      'Add Service charge',
                      duration: Duration(seconds: 3),
                      backgroundColor: red,
                    );
                  } else if (phoneNumber.text.isEmpty) {
                    Get.snackbar(
                      'Error',
                      'Add Service charge',
                      duration: Duration(seconds: 3),
                      backgroundColor: red,
                    );
                  }
                  id != null
                      ? paymentMethodController.updatePaymentMethod(
                        title: titleController.text,
                        index: int.parse(indexController.text),
                        minimumAmount: int.parse(minimumAmount.text),
                        serviceCharge: int.parse(serviceCharge.text),
                        phone: phoneNumber.text,
                        id: id,
                      )
                      : paymentMethodController.addPaymentMethod(
                        title: titleController.text,
                        index: int.parse(indexController.text),
                        minimumAmount: int.parse(minimumAmount.text),
                        serviceCharge: int.parse(serviceCharge.text),
                        phone: phoneNumber.text,
                      );
                },
                child: text(
                  title:
                      id != null
                          ? 'Update Payment Method'
                          : 'Add Payment Method',
                  color: black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
