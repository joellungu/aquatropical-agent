import 'dart:async';

import 'package:aquatropical_agent/pages/accueil.dart';
import 'package:aquatropical_agent/pages/login/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Spalsh extends StatelessWidget {
  //
  var box = GetStorage();
  //
  Spalsh() {
    //
    Map user = box.read("user") ?? {};
    //
    Timer(
      const Duration(seconds: 2),
      () {
        if (user['id'] == null) {
          Get.offAll(Login());
        } else {
          Get.offAll(Accueil());
        }
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    //
    return const Scaffold(
      body: Center(
        child: Text("AquaTropical"),
      ),
    );
  }
}
