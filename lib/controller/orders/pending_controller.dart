import 'package:get/get.dart';
import '../../core/class/statusrequest.dart';
import '../../core/functions/handlingData.dart';
import '../../core/services/services.dart';
import '../../data/datasource/remote/orders/pending_data.dart';
import '../../data/model/ordersmodel.dart';

class OrdersPendingController extends GetxController {

  OrdersPendingData ordersPendingData = OrdersPendingData(Get.find());

  List<OrdersModel> data = [];

  late StatusRequest statusRequest;

  MyServices myServices = Get.find();

  String printOrderType(int val) {
    if (val == 0) {
      return "167".tr;
    } else {
      return "168".tr;
    }
  }

  String printPaymentMethod(int val) {
    if (val == 0) {
      return "165".tr;
    } else {
      return "166".tr;
    }
  }

  String printOrderStatus(int val) {
    if (val == 0) {
      return "160".tr;
    } else if (val == 1) {
      return "161".tr;
    } else if (val == 2) {
      return "162".tr;
    }  else if (val == 3) {
      return "163".tr;
    } else {
      return "164".tr;
    }
  }
  getOrders() async {
    data.clear();
    statusRequest = StatusRequest.loading;
    update();
    var response = await ordersPendingData
        .getData(myServices.sharedPreferences.getString("id")!);
    print("=============================== OrdersPendingController $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        List listdata = response['data'];
        data.addAll(listdata.map((e) => OrdersModel.fromJson(e)));
      } else {
        statusRequest = StatusRequest.failure;
      }
      // End
    }
    update();
  }

  deleteOrder(int orderid) async {
    data.clear();
    statusRequest = StatusRequest.loading;
    update();
    var response = await ordersPendingData.deleteData(orderid.toString());
    print("=============================== OrdersPendingController $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        refrehOrder();
      } else {
        statusRequest = StatusRequest.failure;
      }
      // End
    }
    update();
  }

  refrehOrder() {
    getOrders();
  }

  @override
  void onInit() {
    getOrders();
    super.onInit();
  }
}