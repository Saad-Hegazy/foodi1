import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/myfavoritecontroller.dart';
import '../../core/class/handlingdataview.dart';
import '../../core/constant/color.dart';
import '../../data/model/myfavorite.dart';
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
              const SizedBox(height: 5) ,
              HandlingDataView(
                  statusRequest: controller.statusRequest,
                  widget: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.data.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 0.76),
                    itemBuilder: (context, index) {
                      return  CustomListFavoriteItems(
                        myFavoriteitemsModel: controller.data[index],
                        // onAdd: () {
                        //   controller.addItems(
                        //       controller.data[index].itemsId!,
                        //       "0",
                        //       controller.getPrice(controller.data[index]).toString(),
                        //       1
                        //   );
                        //   Get.snackbar("155".tr, "154".tr,);
                        // },
                      );
                    },
                  )
              )
            ]))),
      ),
    );
  }
}