import 'package:get/get.dart';

import '../controllers/add_notice_controller.dart';

class AddNoticeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddNoticeController>(
      () => AddNoticeController(),
    );
  }
}
