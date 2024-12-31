import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../controller/homescreen_controller.dart';
import 'custombuttonappbar.dart';



class CustomBottomAppBarHome extends StatelessWidget {
  const CustomBottomAppBarHome({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenControllerImp>(
        builder: (controller) => BottomAppBar(
            padding:EdgeInsets.zero,
            shape: const CircularNotchedRectangle(),
            notchMargin: 10,
            child: Row(
                children: [
                  ...List.generate(controller.listPage.length + 1, ((index) {
                    int i = index > 2 ? index - 1 : index;
                    return index == 2
                        ? const Spacer()
                        : CustomButtonAppBar(
                        textbutton: controller.bottomappbar[i]['title'],
                        icondata: controller.bottomappbar[i]['icon'],
                        onPressed: () {
                          controller.changepage(i);
                        },
                        active: controller.currentpage == i ? true : false);
                  }))
                ],
              ),
            ));
  }
}