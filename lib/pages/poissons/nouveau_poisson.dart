import 'package:aquatropical_agent/pages/poissons/poisson_controller.dart';
import 'package:aquatropical_agent/pages/taux_controller.dart';
import 'package:aquatropical_agent/utils/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NouvelPoisson extends StatelessWidget {
  //
  PoissonController poissonController = Get.find();
  //
  TextEditingController nom = TextEditingController();
  //
  TextEditingController prix = TextEditingController();
  //
  TextEditingController taille = TextEditingController();
  //
  TextEditingController quantite = TextEditingController();
  //
  RxDouble taux = 0.0.obs;
  RxDouble prixCDF = 0.0.obs;
  //
  TauxController tauxController = Get.find();
  //
  loadTaux() async {
    //

    //
    taux.value = await tauxController.getTaux2();
  }

  //
  NouvelPoisson() {
    //
    loadTaux();
    //
  }

  //
  List roles = ["Expeditionniste", "Gestionnaire"];
  RxInt role = 0.obs;
  //

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nouvel poisson"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Nom",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              TextField(
                controller: nom,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      15,
                    ),
                  ),
                  hintText: "Nom ( VERNACULAIRES )",
                  prefixIcon: Container(
                    padding: const EdgeInsets.all(5),
                    height: 20,
                    width: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    const Text(
                      "Prix / ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Obx(
                      () => Text(
                        "${taux.value}",
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  ],
                ),
              ),
              TextField(
                onChanged: (t) {
                  //
                  prixCDF.value = double.parse(t) * taux.value;
                  //
                },
                controller: prix,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: "En dollar",
                  suffix: Obx(
                    () => Text(
                      "${prixCDF.value} CDF",
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  prefixIcon: Container(
                    padding: const EdgeInsets.all(5),
                    height: 20,
                    width: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Taille",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              TextField(
                controller: taille,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: "Taille du poisson",
                  prefixIcon: Container(
                    padding: const EdgeInsets.all(5),
                    height: 20,
                    width: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Quantité",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              TextField(
                controller: quantite,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: "Quantité initiale",
                  prefixIcon: Container(
                    padding: const EdgeInsets.all(5),
                    height: 20,
                    width: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  //
                  Loader.attente();
                  /**
                   * public String nom;
      //         public String code;
      //         public double prixUSD;
      //         public double prixCDF;
      //         public int quantite;
      //         public String taille;
                   */
                  //
                  Map poisson = {
                    "nom": nom.text,
                    "prixUSD": prix.text,
                    "prixCDF": prixCDF.value,
                    "taille": taille.text,
                    "quantite": quantite.text,
                  };
                  //
                  poissonController.enregistrement(poisson);
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.green.shade700),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                child: Container(
                  alignment: Alignment.center,
                  height: 45,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.green.shade700,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Text(
                    "Ajouter",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
