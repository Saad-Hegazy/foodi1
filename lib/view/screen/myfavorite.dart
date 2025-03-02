import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/myfavoritecontroller.dart';
import '../../core/class/handlingdataview.dart';
import '../../core/constant/color.dart';
import '../widget/myfavorite/customlistfavoriteitems.dart';
class MyFavorite extends StatelessWidget {
  const MyFavorite({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(MyFavoriteController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title:  Text('195'.tr,style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: GetBuilder<MyFavoriteController>(
            builder: ((controller) => ListView(children: [
              const SizedBox(height: 20) ,
              HandlingDataView(
                  statusRequest: controller.statusRequest,
                  widget: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.data.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 0.7),
                    itemBuilder: (context, index) {
                      return  CustomListFavoriteItems(
                        MyFavoriteitemsModel: controller.data[index],
                      );
                    },
                  ))
            ]))),
      ),
    );
  }
}