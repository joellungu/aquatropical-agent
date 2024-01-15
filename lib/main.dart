import 'package:aquatropical_agent/pages/expeditions/expeditions_controller.dart';
import 'package:aquatropical_agent/pages/fournisseurs/fournisseurs.dart';
import 'package:aquatropical_agent/pages/fournisseurs/fournisseurs_controller.dart';
import 'package:aquatropical_agent/pages/login/login_controller.dart';
import 'package:aquatropical_agent/pages/materiels/materiels_controller.dart';
import 'package:aquatropical_agent/pages/poissons/poisson_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pages/accueil.dart';
import 'pages/journal/journal_controller.dart';

void main() async {
  //
  MaterielController materielController = Get.put(MaterielController());
  //
  FournisseursController fournisseursController =
      Get.put(FournisseursController());
  //
  PoissonController poissonController = Get.put(PoissonController());
  //
  LoginController loginController = Get.put(LoginController());
  //
  ExpeditionController expeditionController = Get.put(ExpeditionController());
  //
  JournalController journalController = Get.put(JournalController());
  //

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'AquaTropical',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        useMaterial3: true,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey.shade400),
      ),
      home: Accueil(),
    );
  }
}
