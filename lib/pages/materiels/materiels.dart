import 'package:aquatropical_agent/pages/fournisseurs/nouveau_fournisseur.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'materiels_controller.dart';
import 'nouveau_materiel.dart';

class Materiel extends GetView<MaterielController> {
  //
  List agents = [
    {},
    {},
  ];
  //
  Materiel() {
    //
    controller.getAll();
    //
  }

  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: controller.obx(
        (state) {
          //
          RxList agents = RxList(state!);
          //
          RxString mot = "".obs;
          //
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: TextField(
                  onChanged: (t) {
                    //
                    mot.value = t;
                    //
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: "Nom du materiel",
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    children: List.generate(agents.length, (index) {
                      //
                      Map produit = agents[index];
                      if ("${produit['nom']}"
                          .toLowerCase()
                          .contains(mot.value.toLowerCase())) {
                        return ListTile(
                          leading: SvgPicture.asset(
                            "assets/SolarBoxLinear.svg",
                            height: 30,
                            width: 30,
                          ),
                          title: Text(
                            "${produit['nom']}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text.rich(
                            TextSpan(
                              text: "${produit['prixUSD']} ",
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
                                  text: "${produit['prixCDF']} CDF",
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
                            "${produit['quantite']}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    }),
                  ),
                ),
              )
            ],
          );
        },
        onLoading: const Center(
          child: SizedBox(
            height: 40,
            width: 40,
            child: CircularProgressIndicator(),
          ),
        ),
        onEmpty: Container(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //
          Get.to(NouveauMateriel());
        },
        child: SvgPicture.asset(
          "assets/GalaAdd.svg",
          height: 30,
          width: 30,
        ),
      ),
    );
  }
}
