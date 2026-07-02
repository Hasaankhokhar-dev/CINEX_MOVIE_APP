import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OtpController  extends GetxController{
  final List<TextEditingController> otpControllers = List.generate(
      4,
      (index) => TextEditingController(),
  );
  final List<FocusNode> focusNodes = List.generate(
    4,
    (index) => FocusNode(),
  );
  void onOtpChanged(String value, int index) {
    if(value.length == 1 && index < 3){
      focusNodes[index + 1].requestFocus();
    }
  }
  void onBackspacePressed(int index) {
    if (index > 0) {
      otpControllers[index].clear();
      focusNodes[index - 1].requestFocus();
    }
  }
  // get otp value in string
  String getOtp() {
    return otpControllers.map((controller) => controller.text).join();
  }
  @override
  // memory free
  void onClose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.onClose();
  }
}