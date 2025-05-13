import 'package:cash_agent_admin/app/constant/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DepositController extends GetxController {
  //TODO: Implement DepositController

  final count = 0.obs;
  RxList<Map<String, dynamic>> depositTransition = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> withdrawTransition =
      <Map<String, dynamic>>[].obs;
  final deposit = FirebaseFirestore.instance.collection('depositRequest');
  final users = FirebaseFirestore.instance.collection('users');
  Future<bool> assetExists(String path) async {
    try {
      await rootBundle.load("assets/img/svg/$path.svg");
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> depositRequestsSortedByDate() async {
    depositTransition.clear();
    final firestore = FirebaseFirestore.instance;

    // Fetch deposit requests
    final depositSnapshot =
        await firestore
            .collection('depositRequest')
            .where('approved', isEqualTo: false)
            .orderBy('time')
            .get();

    for (var doc in depositSnapshot.docs) {
      var data = doc.data();
      depositTransition.add(data);
    }

    print(depositTransition);
    update();
    return depositTransition;
  }

  Future<List<Map<String, dynamic>>> withdrawRequestsSortedByDate() async {
    withdrawTransition.clear();
    final firestore = FirebaseFirestore.instance;

    // Fetch deposit requests
    final withdrawSnapshot =
        await firestore
            .collection('withdrawRequest')
            .where('approved', isEqualTo: false)
            .orderBy('time')
            .get();

    for (var doc in withdrawSnapshot.docs) {
      var data = doc.data();
      withdrawTransition.add(data);
    }

    print(withdrawTransition);
    update();
    return withdrawTransition;
  }

  Future transitionApproved(String id, uId, type, bool action, double amount) {
    return FirebaseFirestore.instance
        .collection(type)
        .doc(id)
        .update({'approved': action})
        .then((value) async {
          await userUpdate(
            uId: uId,
            type: type,
            id: id,
            action: action,
            amount: amount,
          );
          await depositRequestsSortedByDate();
          await withdrawRequestsSortedByDate();
          Get.back();
          Get.snackbar("Attention", "Request approved", backgroundColor: red);
        });
  }

  Future transitionReject(String id, uId, type, bool action, double amount) {
    return FirebaseFirestore.instance
        .collection(type)
        .doc(id)
        .update({'reject': action, 'approved': action})
        .then((value) async {
          await users.doc(uId).collection(type).doc(id).set({
            "reject": action,
            'approved': action,
          }, SetOptions(merge: true));
          await depositRequestsSortedByDate();
          await withdrawRequestsSortedByDate();
          Get.back();
          Get.snackbar("Attention", "Request Rejected", backgroundColor: green);
        });
  }

  Future userUpdate({
    required String uId,
    type,
    id,
    required bool action,
    required double amount,
  }) {
    return users
        .doc(uId)
        .collection(type)
        .doc(id)
        .set({"approved": action}, SetOptions(merge: true))
        .then((value) {
          final updateData = type == "depositRequest" ? 'deposit' : 'withdraw';

          final sfDocRef = users.doc(uId);
          FirebaseFirestore.instance
              .runTransaction((transaction) {
                return transaction.get(sfDocRef).then((sfDoc) {
                  final balance = sfDoc.get(updateData) + amount;
                  transaction.update(sfDocRef, {updateData: balance});
                  return balance;
                });
              })
              .then((value) {});
        });
  }

  void increment() => count.value++;
}
