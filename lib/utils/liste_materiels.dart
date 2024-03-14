import 'dart:convert';

import 'package:aquatropical_agent/pages/journal/journal_controller.dart';
import 'package:aquatropical_agent/pages/materiels/materiels_controller.dart';
import 'package:aquatropical_agent/pages/poissons/poisson_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ListMateriels extends GetView<MaterielController> {
  //
  JournalController journalController = Get.find();
  //
  ListMateriels() {
    //
    controller.getAll();
    //
  }
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      body: controller.obx(
        (state) {
          //
          RxList poissons = RxList(state!);
          //
          RxString mot = "".obs;
          //
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 20, left: 25, right: 25),
                child: TextField(
                  onChanged: (t) {
                    //
                    mot.value = t;
                    //
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: "Nom du poisson",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Obx(
                  () => ListView(
                    padding: EdgeInsets.all(20),
                    children: List.generate(
                      poissons.length,
                      (index) {
                        Map materiel = poissons[index];
                        //
                        if ("${materiel['nom']}"
                            .toLowerCase()
                            .contains(mot.value.toLowerCase())) {
                          //
                          return ListTile(
                            onTap: () {
                              //
                              TextEditingController quantite =
                                  TextEditingController();
                              int qt = materiel['quantite'];
                              //
                              Get.dialog(Center(
                                child: Card(
                                  elevation: 1,
                                  child: SizedBox(
                                    height: 200,
                                    width: 200,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Quantité ($qt)",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: TextField(
                                            controller: quantite,
                                            autofocus: true,
                                            keyboardType: TextInputType.number,
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Get.back();
                                            Get.back();
                                            materiel['quantite'] =
                                                quantite.text;
                                            //
                                            journalController.materiels
                                                .add(materiel);
                                          },
                                          child: const Text("Ajouter"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ));
                            },
                            leading: SvgPicture.asset(
                              "assets/FluentEmojiHighContrastTropicalFish.svg",
                              height: 30,
                              width: 30,
                            ),
                            title: Text(
                              "${materiel['nom']}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text.rich(
                              TextSpan(
                                text: "${materiel['prixUSD']} ",
                                children: [
                                  const TextSpan(
                                    text: "USD\n",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.indigo,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "${materiel['prixCDF']} CDF",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.green.shade900,
                                    ),
                                    //children: [TextSpan(text: "")],
                                  ),
                                ],
                              ),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                            trailing: Text(
                              "${materiel['quantite']}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          );
                          //
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        onEmpty: Container(),
        onLoading: const Center(
          child: SizedBox(
            height: 40,
            width: 40,
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
