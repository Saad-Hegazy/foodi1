import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class NotificationService{
  FirebaseMessaging massaging =FirebaseMessaging.instance;
  void requestNotificationPermattion()async{
    NotificationSettings settings =await massaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if(settings.authorizationStatus==AuthorizationStatus.authorized){
      print("user granted permission");
    }else if( settings.authorizationStatus==AuthorizationStatus.provisional){
      print("user provisional granted permission");
    }else{
      Get.snackbar(
        "Notification Permission denied",
        "Please allow notification to receive updates.",
        snackPosition: SnackPosition.BOTTOM,
      );
      Future.delayed(Duration(seconds: 3),(){
        AppSettings.openAppSettings(type:AppSettingsType.notification);
      });
    }
  }

  Future<String> getDeviceToken()async{
    NotificationSettings settings = await massaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    String? token = await massaging.getToken();
    print("DeviceToken >>>>>>>>>>>$token");
    return token!;
  }

}