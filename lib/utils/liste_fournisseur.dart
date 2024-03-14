import 'dart:convert';
import 'package:aquatropical_agent/pages/fournisseurs/fournisseurs_controller.dart';
import 'package:aquatropical_agent/pages/journal/journal_controller.dart';
import 'package:aquatropical_agent/pages/materiels/materiels_controller.dart';
import 'package:aquatropical_agent/pages/poissons/poisson_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ListFournisseurs extends GetView<FournisseursController> {
  //
  JournalController journalController = Get.find();
  //
  ListFournisseurs() {
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
          RxList fournisseurs = RxList(state!);
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
                    prefixIcon: const Icon(Icons.search),
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
                      fournisseurs.length,
                      (index) {
                        Map fournisseur = fournisseurs[index];
                        //
                        if ("${fournisseur['nom']}"
                            .toLowerCase()
                            .contains(mot.value.toLowerCase())) {
                          //
                          return ListTile(
                            onTap: () {
                              //
                              TextEditingController quantite =
                                  TextEditingController();
                              //
                              journalController.fournisseur.value = fournisseur;
                              //
                              Get.back();
                            },
                            leading: SvgPicture.asset(
                              "assets/GalaPortrait1.svg",
                              height: 30,
                              width: 30,
                            ),
                            title: Text(
                              "${fournisseur['nom']} ${fournisseur['postnom']} ${fournisseur['prenom']}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: RichText(
                              text: TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: [
                                  TextSpan(
                                      text: "${fournisseur['telephone']} "),
                                  TextSpan(
                                    text: "${fournisseur['type']}\n",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "${fournisseur['adresse']}\n",
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15,
                                        color: Colors.indigo),
                                  ),
                                ],
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
