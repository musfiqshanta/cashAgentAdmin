import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AddNoticeController extends GetxController {
  //TODO: Implement AddNoticeController

  final count = 0.obs;

  void increment() => count.value++;
  final admin = FirebaseFirestore.instance.collection('admin');
  Future addNotice(String notice) {
    return admin
        .doc('notice')
        .collection('notices')
        .add({'notice': notice, 'time': DateTime.now()})
        .then((value) {
          print(value);
          Get.back();
        });
  }

  Future updateNotice(String notice, id) {
    return admin
        .doc('notice')
        .collection('notices')
        .doc(id)
        .update({'notice': notice, 'time': DateTime.now()})
        .then((value) {
          Get.back();
        });
  }

  Future removeNotice(String id) {
    return admin.doc('notice').collection('notices').doc(id).delete().then((
      onValue,
    ) {
      Get.back();
    });
  }
}
