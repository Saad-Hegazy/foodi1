import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rating_dialog/rating_dialog.dart';
import '../../../controller/orders/archive_controller.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/imageassets.dart';


void showDialogRating(BuildContext context , String ordersId){
  try {
    showDialog(
      context: context,
      barrierDismissible: true, // set to false if you want to force a rating
      builder: (context) => RatingDialog(
        initialRating: 1.0,
        // your app's name?
        title:  Text(
          '121'.tr,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        // encourage your user to leave a high rating?
        message:  Text(
          '122'.tr,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15),
        ),
        // your app's logo?
        image: Image.asset(AppImageAsset.logo,width: 200,height: 200,),
        submitButtonText: '123'.tr,
        submitButtonTextStyle: const TextStyle(
          color: AppColor.primaryColor,
          fontWeight:FontWeight.bold ,

        ),
        onCancelled: () => {},
        onSubmitted: (response) {
          OrdersArchiveController controller = Get.find() ;
          controller.submitRating( ordersId, response.comment, response.rating.toString() );
        },
      ),
    );
  } catch (e, s) {
    print(s);
  }
}