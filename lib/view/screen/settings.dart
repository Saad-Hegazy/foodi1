import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controller/settings_controller.dart';
import '../../core/constant/color.dart';
import '../../core/constant/imageassets.dart';
import '../../core/constant/routes.dart';
import '../../core/localization/changelocal.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SettingsController controller = Get.put(SettingsController());
    return Container(
      child: ListView(
        children: [
          Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(height: Get.width / 3, color: AppColor.primaryColor),
                Positioned(
                    top: Get.width / 3.9,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100)),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey[100],
                        backgroundImage: const AssetImage(AppImageAsset.avatar),
                      ),
                    )),
              ]),
          const SizedBox(height: 100),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Card(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                ListTile(
                  onTap: () {
                    Get.toNamed(AppRoute.orderspending);
                  },
                  trailing: const Icon(Icons.card_travel),
                  title: Text("40".tr),
                ),
                ListTile(
                  onTap: () {
                    Get.toNamed(AppRoute.ordersarchive );
                  },
                  trailing: const Icon(Icons.card_travel),
                  title:  Text("48".tr),
                ),
                ListTile(
                  onTap: () {
                    Get.toNamed(AppRoute.addressview)  ;
                  },
                  trailing: const Icon(Icons.location_on_outlined),
                  title:  Text("49".tr),
                ),
                ListTile(
                  onTap: () async{
                    await  Get.toNamed(AppRoute.notifications)  ;
                  },
                  trailing: const Icon(Icons.notifications_active_outlined),
                  title:  Text("202".tr),
                ),
                ListTile(
                  onTap: () async{
                  await  launchUrl(Uri.parse("tel:+966569222419"));
                  },
                  trailing: const Icon(Icons.phone_callback_outlined),
                  title:  Text("50".tr),
                ),
                ListTile(
            onTap: () {
              LocaleController controller = Get.put(LocaleController());
              final newLang = Get.locale?.languageCode == 'ar' ? 'en' : 'ar';
              controller.changeLang(newLang);
                  },
                  title:  Text("198".tr),
                  trailing: const Icon(Icons.language),
                ),
                ListTile(
                  onTap: () async{
                    await  launch("https://foodi1.com/foodi1backend/upload/document/VAT.pdf");
                  },
                  title:  Text("199".tr),
                  trailing: const Icon(Icons.checklist_rtl),
                ),
                ListTile(
                  onTap: () {
                    controller.logout();
                  },
                  title:  Text("51".tr),
                  trailing: const Icon(Icons.exit_to_app),
                ),
              ]),
            ),
          )
        ],
      ),
    );
  }
}