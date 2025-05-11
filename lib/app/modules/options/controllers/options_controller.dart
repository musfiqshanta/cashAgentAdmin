import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class OptionsController extends GetxController {
  //TODO: Implement OptionsController

  final count = 0.obs;



  final options = FirebaseFirestore.instance.collection('admin').doc('urls');

  Future<void> updateOptions({
    required String city,
    contact,
    downloadUrl,
    share,
    street,
    telegram,
    youtube,
  }) {
    return options
        .update({
          "city": city,
          "contact": contact,
          "downloadUrl": downloadUrl,
          "share": share,
          "street": street,
          "telegram": telegram,
          "youtube": youtube,
        })
        .then((onValue) {
          Get.back();
        });
  }

  void increment() => count.value++;
}
