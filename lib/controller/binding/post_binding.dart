import 'package:get/get.dart';
import 'package:work_shop_new/controller/postcontroller/post_controller.dart';

class PostBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(PostController());
  }
}
