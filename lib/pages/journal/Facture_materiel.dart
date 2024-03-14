import 'package:aquatropical_agent/utils/frais_supplementaire.dart';
import 'package:aquatropical_agent/utils/liste_fournisseur.dart';
import 'package:aquatropical_agent/utils/liste_materiels.dart';
import 'package:aquatropical_agent/utils/liste_poissons.dart';
import 'package:aquatropical_agent/utils/loader.dart';
import 'package:aquatropical_agent/utils/recherche.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'journal_controller.dart';

class FactureMateriel extends StatelessWidget {
  //
  RxDouble taux = 0.0.obs;
  //
  FactureMateriel() {
    //
    taux.value = (box.read("taux") + 0.0) ?? 0;
  }
  //
  var box = GetStorage();
  //
  JournalController journalController = Get.find();
  //
  RxBool fournisseurVue = false.obs;
  //
  RxBool poissonVue = false.obs;
  //
  RxInt devise = 0.obs;
  RxList devises = ["USD", "CDF"].obs;
  //
  @override
  Widget build(BuildContext context) {
    //
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Produits & Materiels (${taux.value} = 1\$)",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
        Container(
          //height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey),
          ),
          //height: 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListTile(
                onTap: () {
                  //
                  showSimpleModal(ListMateriels(), context);
                },
                title: const Text("Ajouter"),
                trailing: const Icon(Icons.add),
              ),
              Obx(
                () => Column(
                  children: List.generate(
                    journalController.materiels.length,
                    (index) {
                      Map materiel = journalController.materiels[index];
                      return ListTile(
                        leading: SvgPicture.asset(
                          "assets/SolarBoxLinear.svg",
                          height: 30,
                          width: 30,
                        ),
                        title: Text(
                          "${materiel['nom']}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("${materiel['prixUSD']} "),
                            Text(
                              "x ",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              "${materiel['quantite']} = ",
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              "${double.parse(materiel['quantite']) * materiel['prixUSD']} ",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              "USD",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.indigo),
                            ),
                          ],
                        ),
                        trailing: InkWell(
                          onTap: () {
                            //
                            journalController.materiels.removeAt(index);
                            //
                          },
                          child: Icon(
                            Icons.delete,
                            color: Colors.red.shade700,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Devise",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
        Container(
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey.shade500, width: 1),
          ),
          child: Obx(
            () => DropdownButtonHideUnderline(
              child: DropdownButton(
                isExpanded: true,
                padding: const EdgeInsets.only(left: 10),
                value: devise.value,
                onChanged: (e) {
                  //
                  devise.value = e as int;
                },
                items: List.generate(
                  devises.length,
                  (index) => DropdownMenuItem(
                    value: index,
                    child: Text(
                      "${devises[index]}",
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        // const Align(
        //   alignment: Alignment.centerLeft,
        //   child: Text(
        //     "Faris supplementaire",
        //     style: TextStyle(
        //       fontWeight: FontWeight.bold,
        //       fontSize: 15,
        //     ),
        //   ),
        // ),
        // Container(
        //   //height: 50,
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(10),
        //     border: Border.all(color: Colors.grey),
        //   ),
        //   //height: 50,
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     children: [
        //       ListTile(
        //         onTap: () {
        //           //
        //           showSimpleModal(FraisSupplementaire(), context);
        //         },
        //         title: const Text("Ajouter"),
        //         trailing: const Icon(Icons.add),
        //       ),
        //       Obx(
        //         () => Column(
        //           children: List.generate(
        //             journalController.fraisSupplementaire.length,
        //             (index) {
        //               Map frais = journalController.fraisSupplementaire[index];
        //               return ListTile(
        //                 leading: SvgPicture.asset(
        //                   "assets/SolarBoxLinear.svg",
        //                   height: 30,
        //                   width: 30,
        //                 ),
        //                 title: Text(
        //                   "${frais['type']}",
        //                   style: const TextStyle(
        //                     fontWeight: FontWeight.bold,
        //                   ),
        //                 ),
        //                 subtitle: Row(
        //                   mainAxisAlignment: MainAxisAlignment.start,
        //                   children: [
        //                     Text("${frais['montant']} "),
        //                     Text(
        //                       "${frais['devise']} ",
        //                       style: const TextStyle(
        //                         fontWeight: FontWeight.bold,
        //                         fontSize: 15,
        //                         color: Colors.indigo,
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //                 trailing: InkWell(
        //                   onTap: () {
        //                     //
        //                     journalController.fraisSupplementaire
        //                         .removeAt(index);
        //                     //
        //                   },
        //                   child: Icon(
        //                     Icons.delete,
        //                     color: Colors.red.shade700,
        //                   ),
        //                 ),
        //               );
        //             },
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),

        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {
            Loader.attente();

            //
            DateTime date = DateTime.now();
            //
            String d = "${date.day}-${date.month}-${date.year}";
            String h = "${date.hour}:${date.minute}";
            //
            Map facture = {
              "date": d,
              "heure": h,
              "entreeUSD": 0.0,
              "entreeCDF": 0.0,
              "depenseUSD": 0.0,
              "depenseCDF": 0.0,
              "remarque": 0.0,
              "taux": taux.value,
              "devise": devises[devise.value],
              "materiels": journalController.materiels.value,
              //"frais": journalController.fraisSupplementaire.value,
              "categorie": "Facture Materiel",
            };
            //
            journalController.enregistrement(facture, d);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green.shade700),
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
              "Enregistrer",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
  //
}
