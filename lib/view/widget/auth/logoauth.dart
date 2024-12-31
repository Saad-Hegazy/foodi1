import 'package:flutter/material.dart';

import '../../../core/constant/color.dart';
import '../../../core/constant/imageassets.dart';
class LogoAuth extends StatelessWidget {
  const LogoAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: 70,
        backgroundColor: AppColor.primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(0), // Border radius
          child: ClipOval(
            child: Image.asset(
              AppImageAsset.logo,
              fit: BoxFit.cover,
            ),
          ),
        ));
  }
}
