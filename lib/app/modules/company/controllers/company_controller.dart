import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CompanyController extends GetxController {
  //TODO: Implement CompanyController

  final count = 0.obs;
  final company = FirebaseFirestore.instance.collection('company');
  void increment() => count.value++;
  final Rx<File?> imageFile = Rx<File?>(null);
  final picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
      await uploadToFirebase(imageFile.value!);
    }
  }

  Future<void> uploadToFirebase(File imageFile) async {
    try {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final ref = FirebaseStorage.instance.ref().child('uploads/$fileName.jpg');
      await ref.putFile(imageFile);
      final downloadUrl = await ref.getDownloadURL();
      print('Uploaded! URL: $downloadUrl');
      Get.snackbar(
        'Success',
        'Image uploaded!',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      print('Error uploading: $e');
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> addCompany(String title, int index) {
    return company.add({'title': title, 'index': index}).then((value) {
      Get.back();
    });
  }

  Future<void> updateCompany(String title, id, int index) {
    return company.doc(id).update({'title': title, 'index': index}).then((
      value,
    ) {
      Get.back();
    });
  }

  Future<void> deleteCompany(String title, id, int index) {
    return company.doc(id).delete().then((value) {
      Get.back();
    });
  }
}
