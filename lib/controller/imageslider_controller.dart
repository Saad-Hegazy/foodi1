import 'package:get/get.dart';
import '../core/class/statusrequest.dart';
import '../core/functions/handlingData.dart';
import '../core/services/services.dart';
import '../data/datasource/remote/imageslider_data.dart';

class  ImagesliderController extends GetxController {
  ImagesliderData imagesliderData = ImagesliderData(Get.find());
   List data =[] ;
  late StatusRequest statusRequest;
  MyServices myServices = Get.find();
  @override
  void onInit() {
    getImageslider();
    super.onInit();
  }
  getImageslider() async {
    data.clear();
    statusRequest = StatusRequest.loading;
    update();
    var response = await imagesliderData.getData(
        myServices.sharedPreferences.getString("userType")!
    );
    print("=============================== ImagesliderController $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        data.addAll(response['data']);
      } else {
        statusRequest = StatusRequest.failure;
      }
      // End
    }
    update();
  }


}