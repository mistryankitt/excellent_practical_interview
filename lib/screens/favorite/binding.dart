import 'package:excellent_practical_interview/screens/home/logic.dart';
import 'package:get/get.dart';

import 'logic.dart';

class FavoriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FavoriteLogic());
    Get.lazyPut(() => HomeLogic());
  }
}
