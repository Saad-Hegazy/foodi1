import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controller/settings_controller.dart';
import '../../core/constant/color.dart';
import '../../core/constant/imageassets.dart';
import '../../core/constant/routes.dart';

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
                  title: const Text("Orders"),
                ),
                ListTile(
                  onTap: () {
                    Get.toNamed(AppRoute.ordersarchive );
                  },
                  trailing: const Icon(Icons.card_travel),
                  title: const Text("Archive"),
                ),
                ListTile(
                  onTap: () {
                    Get.toNamed(AppRoute.addressview)  ;
                  },
                  trailing: const Icon(Icons.location_on_outlined),
                  title: const Text("Address"),
                ),
                // ListTile(
                //   onTap: () {},
                //   trailing: Icon(Icons.help_outline_rounded),
                //   title: Text("About us"),
                // ),
                ListTile(
                  onTap: () async{
                  await  launchUrl(Uri.parse("tel:+97337044837"));
                  },
                  trailing: const Icon(Icons.phone_callback_outlined),
                  title: const Text("Contact us"),
                ),
                ListTile(
                  onTap: () {
                    controller.logout();
                  },
                  title: const Text("Logout"),
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