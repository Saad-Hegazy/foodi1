import 'package:get/get.dart';
import '../controller/cartlocal_controller.dart';
import '../controller/favorite_controller.dart';
import '../core/class/crud.dart';

class InitialBindings extends Bindings{
  @override
  void dependencies() {
   Get.put(Crud());
   Get.put(CartControllerLocal());
   Get.put(FavoriteController());

  }
}