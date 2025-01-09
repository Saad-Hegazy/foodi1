import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import '../../controller/orders/pending_controller.dart';

class FcmService{
  static void firbaseInit(){
    FirebaseMessaging.onMessage.listen((message){
      if (message.notification != null) {
        OrdersPendingController ordersPendingController= Get.put(OrdersPendingController());
        ordersPendingController.getOrders();
        print(message.notification!.title);
        print(message.notification!.body);
      }});}

}