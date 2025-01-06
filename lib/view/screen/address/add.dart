import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../controller/address/add_controller.dart';
import '../../../core/class/handlingdataview.dart';
import '../../../core/constant/color.dart';


class AddressAdd extends StatelessWidget {
  const AddressAdd({super.key});
  @override
  Widget build(BuildContext context) {
     Get.put(AddAddressController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,

        title:  Text('101'.tr,style: TextStyle(color: Colors.white)),
      ),
      body: GetBuilder<AddAddressController>(
          builder: ((controllerpage) => HandlingDataView(
              statusRequest: controllerpage.statusRequest,
              widget: Column(children: [
                if (controllerpage.kGooglePlex != null)
                  Expanded(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          GoogleMap(
                            mapType: MapType.normal,
                            markers: controllerpage.markers.toSet(),
                            onTap: (latlong) {
                              controllerpage.addMarkers(latlong);
                            },
                            initialCameraPosition: controllerpage.kGooglePlex!,
                            onMapCreated: (GoogleMapController controllermap) {
                              controllerpage.completercontroller!
                                  .complete(controllermap);
                            },
                          ),
                          Positioned(
                            bottom: 10,
                            child: Container(
                              child: MaterialButton(
                                minWidth: 200,
                                onPressed: () {
                                  controllerpage.goToPageAddDetailsAddress();
                                },
                                color: AppColor.primaryColor,
                                textColor: Colors.white,
                                child:
                                 Text("102".tr, style: TextStyle(fontSize: 18)),
                              ),
                            ),
                          )
                        ],
                      ))
              ])))),
    );
  }
}