import 'package:aquatropical_agent/pages/materiels/materiels_controller.dart';
import 'package:aquatropical_agent/pages/taux_controller.dart';
import 'package:aquatropical_agent/utils/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NouveauMateriel extends StatelessWidget {
  //
  MaterielController materielController = Get.find();
  //
  final nom = TextEditingController();
  final prix = TextEditingController();
  final quantite = TextEditingController();

  //
  List roles = ["USD", "CDF"];
  RxInt role = 0.obs;
  ////
  TauxController tauxController = Get.find();
  //
  RxDouble taux = 0.0.obs;
  RxDouble prixCDF = 0.0.obs;
  //
  loadTaux() async {
    //

    //
    taux.value = await tauxController.getTaux2();
  }

  //
  NouveauMateriel() {
    //
    loadTaux();
    //
  }
  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nouveau materiel"),
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
                      borderRadius: BorderRadius.circular(15)),
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
                  "Quantite",
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
                      borderRadius: BorderRadius.circular(15)),
                  prefixIcon: Container(
                    padding: const EdgeInsets.all(5),
                    height: 20,
                    width: 20,
                  ),
                ),
              ),
              // const SizedBox(
              //   height: 10,
              // ),
              // const Align(
              //   alignment: Alignment.centerLeft,
              //   child: Text(
              //     "Devise",
              //     style: TextStyle(
              //       fontWeight: FontWeight.bold,
              //       fontSize: 15,
              //     ),
              //   ),
              // ),
              // Container(
              //   height: 60,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(15),
              //       border: Border.all(color: Colors.grey.shade500, width: 1)),
              //   child: Obx(
              //     () => DropdownButtonHideUnderline(
              //       child: DropdownButton(
              //         isExpanded: true,
              //         padding: const EdgeInsets.only(left: 10),
              //         value: role.value,
              //         onChanged: (e) {
              //           //
              //           role.value = e as int;
              //         },
              //         items: List.generate(
              //           roles.length,
              //           (index) => DropdownMenuItem(
              //             value: index,
              //             child: Text(
              //               "${roles[index]}",
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Loader.attente();
                  //
                  Map materiel = {
                    "nom": nom.text,
                    "prixUSD": prix.text,
                    "prixCDF": prixCDF.value,
                    "quantite": quantite.text,
                  };
                  /**
                   */
                  materielController.enregistrement(materiel);
                  //
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
