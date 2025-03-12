import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/address/view_controller.dart';
import '../../../core/class/handlingdataview.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/routes.dart';
import '../../../data/model/addressmodel.dart';


class AddressView extends StatelessWidget {
  const AddressView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AddressViewController());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.primaryColor,
          title:  Text('92'.tr,style: TextStyle(color: Colors.white)),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.toNamed(AppRoute.addressadd);
            },
            child: const Icon(Icons.add)),
        body: GetBuilder<AddressViewController>(
          builder: (controller) => HandlingDataView(
            statusRequest: controller.statusRequest,
            widget: ListView.builder(
              itemCount: controller.data.length,
              itemBuilder: (context, i) {
                return CardAddress(
                  addressModel: controller.data[i],
                    onDelete:(){Get.defaultDialog(
                        title: "158".tr,
                        middleText: "180".tr,
                        onCancel: (){},
                        onWillPop:null,
                        onConfirm:(){
                          controller.deleteAddress(controller.data[i].addressId!);
                          Get.back();
                        }
                    );}
                );
              },
            ),
          ),
        ));
  }
}

class CardAddress extends StatelessWidget {
  final AddressModel addressModel;
  final void Function()? onDelete;
  const CardAddress({Key? key, required this.addressModel, this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          padding: const EdgeInsets.all(10),
          child: ListTile(
            title: Text(addressModel.addressName!),
            subtitle: Text(
                "${addressModel.addressCity!} ${addressModel.addressStreet}"),
            trailing: IconButton(
                onPressed: onDelete, icon: const Icon(Icons.delete_outline)),
          )),
    );
  }
}