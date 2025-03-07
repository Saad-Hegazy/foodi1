import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../controller/homescreen_controller.dart';
import '../../../core/constant/color.dart';
import 'custombuttonappbar.dart';



class CustomBottomAppBarHome extends StatelessWidget {
  const CustomBottomAppBarHome({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenControllerImp>(
        builder: (controller) => BottomAppBar(
          height: 55,
          padding: EdgeInsets.zero,
          child: Row(
            children: [
              ...List.generate(
                controller.listPage.length,
                    (i) => Expanded( // Add Expanded here
                  child: CustomButtonAppBar(
                    textbutton: controller.bottomappbar[i]['title'],
                    icondata: controller.bottomappbar[i]['icon'],
                    onPressed: () => controller.changepage(i),
                    active: controller.currentpage == i,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}