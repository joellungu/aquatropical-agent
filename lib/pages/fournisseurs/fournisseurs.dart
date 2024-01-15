import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'details_fournisseur.dart';
import 'fournisseurs_controller.dart';
import 'nouveau_fournisseur.dart';

class Fournisseur extends GetView<FournisseursController> {
  //
  List agents = [
    {},
    {},
  ];
  //
  Fournisseur() {
    //
    controller.getAll();
    //
  }

  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      body: controller.obx(
        (state) {
          //
          List agents = state!;
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
                    hintText: "Nom du fournisseur",
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
                      if ("${produit['nom']} ${produit['postnom']} ${produit['prenom']}"
                          .toLowerCase()
                          .contains(mot.value.toLowerCase())) {
                        return InkWell(
                          splashColor: Colors.blue.shade100.withOpacity(0.5),
                          onTap: () {
                            //
                            Get.to(
                              DetailFournisseur(produit),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            height: Get.size.height / 5,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    elevation: 1,
                                    child: SizedBox(
                                      height: Get.size.height / 7,
                                      width: double.maxFinite,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Container(),
                                          ),
                                          Expanded(
                                            flex: 8,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Expanded(
                                                  flex: 3,
                                                  child: Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "${produit['nom']} ${produit['postnom']} ${produit['prenom']}",
                                                      style: TextStyle(
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    //color: Colors.amber,
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "${produit['telephone']}",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors
                                                            .teal.shade700,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    //color: Colors.cyan,
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "${produit['type']}",
                                                      style: TextStyle(
                                                        color: Colors
                                                            .blue.shade700,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    //color: Colors.teal,
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        "${produit['adresse']}",
                                                        style: TextStyle(
                                                          color: Colors
                                                              .grey.shade700,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 13,
                                                        ),
                                                      )
                                                      //color: Colors.teal,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 15, left: 5),
                                  padding: const EdgeInsets.all(3),
                                  height: Get.size.height / 4,
                                  width: Get.size.width / 4.5,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.blue.shade100.withOpacity(0.1),
                                        Colors.blue.shade100.withOpacity(0.1),
                                        Colors.blue.shade100.withOpacity(0.3),
                                        Colors.blue.shade100.withOpacity(0.4),
                                        Colors.blue.shade100.withOpacity(0.5),
                                        Colors.blue.shade100,
                                        Colors.blue.shade200,
                                        Colors.blue.shade300,
                                        Colors.blue.shade700,
                                      ],
                                      //tileMode: TileMode.decal,
                                      //stops: [0.1, 0.2, 0.3],
                                    ),
                                  ),
                                  // child: SvgPicture.asset(
                                  //   "assets/GalaPortrait1.svg",
                                  //   height: 80,
                                  //   width: 50,
                                  // ),
                                  child: Icon(
                                    CupertinoIcons.person,
                                    size: 100,
                                  ),
                                ),
                              ],
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
          Get.to(NouvelFournisseur());
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
