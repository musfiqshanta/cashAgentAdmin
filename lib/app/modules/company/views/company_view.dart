import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/company_controller.dart';


class CompanyView extends GetView<CompanyController> {
  const CompanyView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Company'), centerTitle: true),
      body: const Center(
        child: Text('CompanyView is working', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
