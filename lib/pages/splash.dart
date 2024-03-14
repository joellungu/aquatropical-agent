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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     //
      //     //
      //     FilePickerResult? result = await FilePicker.platform.pickFiles(
      //       dialogTitle: "Fichier CSV de la commande",
      //       type: FileType.custom,
      //       allowedExtensions: ["CSV", "csv"],
      //     );
      //     //
      //     if (result != null) {
      //       //fl = result;
      //       File file = File(result.files.single.path!);
      //       // rowsAsListOfValues = await file
      //       //     .openRead()
      //       //     .transform(utf8.decoder)
      //       //     .transform(CsvToListConverter())
      //       //     .toList();
      //       //
      //       //filename.value = result.names[0]!;
      //       //
      //       //print('fields: $rowsAsListOfValues');
      //       //
      //       List<String> l = file.readAsLinesSync(); //.split("\n");
      //       l.removeAt(0);
      //       //
      //       l.forEach((e) {
      //         List es = e.split(";");
      //         //rowsAsListOfValues.add(es);
      //         //
      //       });
      //       //
      //       //rowsAsListOfValues.value = const CsvToListConverter().convert(data);
      //       //
      //       // print("dataa: ${l.length}");
      //       // print("data: ${rowsAsListOfValues.length}");
      //       // //
      //       // final input = File(fichier).openRead();
      //     } else {
      //       // User canceled the picker
      //     }
      //     //
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
