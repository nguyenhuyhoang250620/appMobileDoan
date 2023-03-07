import 'package:app_mobile_doan/core/utils/color_constant.dart';
import 'package:app_mobile_doan/presentation/login_screen/widget/login_content.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:play_kit/play_kit.dart';

import '../../theme/app_style.dart';
import 'controller/login_controller.dart';
import 'package:flutter/material.dart';

class LoginScreen extends GetWidget<LoginController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: ColorConstant.whiteA700,
      body: LoginContent(loginController: controller)
    ));
  }
}
