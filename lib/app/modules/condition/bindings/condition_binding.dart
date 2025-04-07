import 'package:get/get.dart';

import '../controllers/condition_controller.dart';

class ConditionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConditionController>(
      () => ConditionController(),
    );
  }
}
