import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class PaymentMethodController extends GetxController {
  //TODO: Implement PaymentMethodController
  final paymentMethod = FirebaseFirestore.instance.collection('paymentMethod');
  final count = 0.obs;

  void increment() => count.value++;

  Future<void> addPaymentMethod({
    required String title,
    required int minimumAmount,
    required int serviceCharge,
    required int index,
    required String phone,
  }) {
    return paymentMethod
        .add({
          'title': title,
          "minimumAmount": minimumAmount,
          'serviceCharge': serviceCharge,
          'index': index,
          'phone': phone,
        })
        .then((value) {
          Get.back();
        });
  }

  Future<void> updatePaymentMethod({
    required String title,
    required int minimumAmount,
    required int serviceCharge,
    required int index,
    required String phone,
    required String? id,
  }) {
    return paymentMethod
        .doc(id)
        .update({
          'title': title,
          "minimumAmount": minimumAmount,
          'serviceCharge': serviceCharge,
          'index': index,
          'phone': phone,
        })
        .then((value) {
          Get.back();
        });
  }

  Future<void> deletePaymentMethod(String id) {
    return paymentMethod.doc(id).delete().then((onValue) {
      Get.back();
    });
  }
}
