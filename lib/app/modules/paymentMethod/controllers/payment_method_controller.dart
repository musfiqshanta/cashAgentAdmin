import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class PaymentMethodController extends GetxController {
  //TODO: Implement PaymentMethodController
  final paymentMethod = FirebaseFirestore.instance.collection('paymentMethod');
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  Future<void> addPaymentMethod({
    required String title,
    required int minimumAmount,
    required int serviceCharge,
    required int index,
  }) {
    return paymentMethod
        .add({
          'title': title,
          "minimumAmount": minimumAmount,
          'serviceCharge': serviceCharge,
          'index': index,
        })
        .then((value) {
          Get.back();
        });
  }
}
