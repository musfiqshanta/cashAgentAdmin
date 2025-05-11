import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ConditionController extends GetxController {
  //TODO: Implement ConditionController
  final count = 0.obs;

  void increment() => count.value++;
  final admin = FirebaseFirestore.instance.collection('admin');
  Future addCondition(String condition) {
    return admin
        .doc('condition')
        .collection('conditions')
        .add({'condition': condition, 'time': DateTime.now()})
        .then((value) {
          print(value);
          Get.back();
        });
  }
  Future updateCondition(String condition,id) {
    return admin
        .doc('condition')
        .collection('conditions').doc(id)
        .update({'condition': condition, 'time': DateTime.now()})
        .then((value) {
       
          Get.back();
        });
  }

  Future removeNotice(String id) {
    return admin
        .doc('condition')
        .collection('conditions')
        .doc(id)
        .delete()
        .then((value) {
          Get.back();
        });
  }
}
