import 'dart:convert';

import 'package:aquatropical_agent/pages/journal/details_journal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'exceller.dart';
import 'journal_controller.dart';
import 'nouveau_journal.dart';

class Journal extends GetView<JournalController> {
  //
  RxList mois = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
  ].obs;
  //
  RxInt iMois = 1.obs;
  RxInt iAnnee = 2024.obs;
  //
  List resultats = [];
  //
  Journal() {
    //
    DateTime date = DateTime.now();
    //
    String d = "${date.day}-${date.month}-${date.year}";
    //
    controller.getForMonth("${date.month}", "${date.year}");
    //
  }
  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      //appBar: AppBar(),
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.indigo, width: 1),
                    ),
                    child: Obx(
                      () => DropdownButtonHideUnderline(
                        child: DropdownButton(
                          onChanged: (m) {
                            //
                            iMois.value = m as int;
                          },
                          value: iMois.value,
                          items: List.generate(mois.length, (index) {
                            return DropdownMenuItem(
                              child: Text("${index + 1}"),
                              value: index + 1,
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.indigo, width: 1),
                    ),
                    child: Obx(
                      () => DropdownButtonHideUnderline(
                        child: DropdownButton(
                          onChanged: (m) async {
                            //
                            iAnnee.value = m as int;
                            //

                            controller.getForMonth(
                                "${iMois.value}", "${iAnnee.value}");
                          },
                          value: iAnnee.value,
                          items: List.generate(100, (index) {
                            return DropdownMenuItem(
                              child: Text("${index + 2024}"),
                              value: index + 2024,
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 3,
                  child: PopupMenuButton(
                    itemBuilder: (c) {
                      return [
                        PopupMenuItem(
                          child: Text("Excel"),
                          onTap: () {
                            //
                            Get.to(Exceller(resultats));
                          },
                        ),
                        PopupMenuItem(
                          child: Text("PDF"),
                        ),
                      ];
                    },
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: controller.obx(
              (state) {
                List saisies = state!;
                resultats = saisies;
                return ListView(
                  padding: const EdgeInsets.all(10),
                  children: List.generate(
                    saisies.length,
                    (index) {
                      Map saisie = saisies[index];
                      //
                      print("saisie: $saisie");
                      //
                      return InkWell(
                        onTap: () {
                          if (saisie['categorie'] == "Facture Poisson") {
                            Get.to(DetailsJournal(saisie['idFacture']));
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.all(3),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.indigo, width: 1),
                          ),
                          //height: 200,
                          width: double.maxFinite,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "${saisie['categorie']}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  saisie['categorie']
                                          .contains("Facture Poisson")
                                      ? Align(
                                          alignment: Alignment.center,
                                          child: Icon(Icons.print))
                                      : Container(),
                                ],
                              ),
                              const Divider(),

                              saisie['categorie'] == 'Facture Materiel' ||
                                      saisie['categorie'] == 'Facture Poisson'
                                  ? Container()
                                  : Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.center,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Devise ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                "${saisie['devise']}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        Colors.green.shade900),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Montant: ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                "${saisie['montant']}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        Colors.green.shade900),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                              //
                              //
                              const Divider(),

                              saisie['categorie'] == 'Facture Materiel'
                                  ? Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "${jsonDecode(saisie['remarque'])['nom']} (${jsonDecode(saisie['remarque'])['quantite']})",
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  : Container(),
                              saisie['categorie'] == 'Salaire' ||
                                      saisie['categorie'] == "Soins médicaux"
                                  ? Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "${saisie['remarque']}",
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  : Container(),
                              //
                              saisie['categorie'] == 'Perte poissons'
                                  ? Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "${jsonDecode(saisie['remarque'])['nom']}",
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  : Container(),

                              saisie['categorie'] == 'Facture Poisson'
                                  ? Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "${saisie['remarque']}".split(",")[1],
                                        overflow: TextOverflow.clip,
                                        //[0]['poisson']['nom']
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  : Container(),

                              saisie['categorie'] == 'Entrée Caisse' ||
                                      saisie['categorie'] ==
                                          'Prestation de service' ||
                                      saisie['categorie'] == 'Loyer' ||
                                      saisie['categorie'] ==
                                          'Autres depenses' ||
                                      saisie['categorie'] == 'Transport' ||
                                      saisie['categorie'] == 'Vie Kin' ||
                                      saisie['categorie'] == 'XCH'
                                  ? Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "${saisie['remarque']}",
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  : Container(),
                              const Divider(),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "${saisie['date']}  ${saisie['heure']}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
              onEmpty: Container(),
              onError: (e) {
                return Center(
                  child: Text("Erreur code: $e"),
                );
              },
              onLoading: const Center(
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //
          controller.getTaux();
          //
          Get.to(NouveauJournal());
          //
        },
        child: Icon(Icons.add),
      ),
    );
  }

  //
  String poiss(List poissons) {
    String ps = "";
    poissons.forEach((element) {
      //
      ps = "$ps ${element['poisson']['nom']}\n";
    });
    return ps;
  }
}
