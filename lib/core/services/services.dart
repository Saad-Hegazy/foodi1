import 'package:firebase_core/firebase_core.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../firebase_options.dart';
import 'fcm_service.dart';
import 'get_service_key.dart';
import 'notification_service.dart';

class MyServices extends GetxService{
  late SharedPreferences sharedPreferences;
  Future<MyServices> init() async{
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }


}

initialServices()async{
  await Get.putAsync(() => MyServices().init());
  GetServerKey getServerKey=GetServerKey();
  getServerKey.getServerKeyToken();
  NotificationService notificationService=NotificationService();
  notificationService.requestNotificationPermattion();
  notificationService.getDeviceToken();
  FcmService.firbaseInit();
  await Geolocator.isLocationServiceEnabled();
  await Geolocator.checkPermission();


}