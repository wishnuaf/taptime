import 'package:get/get.dart';

import '../controllers/authgate_controller.dart';

class AuthgateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthgateController>(
      () => AuthgateController(),
    );
  }
}
