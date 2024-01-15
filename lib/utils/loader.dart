import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Loader {
  static attente() {
    Get.dialog(
      const Center(
        child: SizedBox(
          height: 40,
          width: 40,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
