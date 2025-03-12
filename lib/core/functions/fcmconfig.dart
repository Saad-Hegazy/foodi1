import 'package:get/get.dart';
import '../../controller/orders/pending_controller.dart';




refreshPageNotification(data) {

  print(Get.currentRoute);

  if (Get.currentRoute == "/orderspending" &&
      data['pagename'] == "refreshorderpending") {
    OrdersPendingController controller = Get.find();
    controller.refrehOrder();
  }
}
