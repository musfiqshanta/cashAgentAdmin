import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  //TODO: Implement UserController

  final count = 0.obs;
  final user = FirebaseFirestore.instance.collection('users');
  RxList<Map<String, dynamic>> depositHistory = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> withdrawHistory = <Map<String, dynamic>>[].obs;

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

  Future<void> promoUser(String id, bool promo) {
    promo = !promo;
    return user.doc(id).set({"promo": promo}, SetOptions(merge: true));
  }

  Future<List<Map<String, dynamic>>> depositRequestsSortedByDate(String id) async {
    depositHistory.clear();
    final firestore = FirebaseFirestore.instance;

    // Fetch deposit requests
    final depositSnapshot =
        await firestore
            .collection('users')
            .doc(id)
            .collection('depositRequest')
            .orderBy('time')
            .get();

    for (var doc in depositSnapshot.docs) {
      var data = doc.data();
      depositHistory.add(data);
    }

    print(depositHistory);
    update();
    return depositHistory;
  }

  Future<List<Map<String, dynamic>>> withdrawRequestsSortedByDate(String id) async {
    withdrawHistory.clear();
    final firestore = FirebaseFirestore.instance;

    // Fetch deposit requests
    final withdrawSnapshot =
        await firestore
            .collection('users')
            .doc(id)
            .collection('withdrawRequest')
            .orderBy('time')
            .get();

    for (var doc in withdrawSnapshot.docs) {
      var data = doc.data();
      // fallback
      withdrawHistory.add(data);
    }

    print(withdrawHistory);
    update();
    return withdrawHistory;
  }

  Future<bool> assetExists(String path) async {
    try {
      await rootBundle.load("assets/img/svg/$path.svg");
      return true;
    } catch (e) {
      return false;
    }
  }

  void increment() => count.value++;
}
