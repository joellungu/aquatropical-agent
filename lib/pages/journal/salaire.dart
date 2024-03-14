import 'package:aquatropical_agent/utils/frais_supplementaire.dart';
import 'package:aquatropical_agent/utils/liste_agents.dart';
import 'package:aquatropical_agent/utils/liste_fournisseur.dart';
import 'package:aquatropical_agent/utils/liste_poissons.dart';
import 'package:aquatropical_agent/utils/loader.dart';
import 'package:aquatropical_agent/utils/recherche.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'journal_controller.dart';

class Salaire extends StatelessWidget {
  //
  RxDouble taux = 0.0.obs;

  //
  RxInt devise = 0.obs;
  RxList devises = ["USD", "CDF"].obs;
  //
  JournalController journalController = Get.find();
  //
  Salaire() {
    //
    taux.value = (box.read("taux") + 0.0) ?? 0;
    taux_.text = "${taux.value}";
  }
  //
  var box = GetStorage();
  //
  TextEditingController montant = TextEditingController();
  TextEditingController taux_ = TextEditingController();

  //
  //
  RxBool fournisseurVue = false.obs;
  //
  RxBool poissonVue = false.obs;
  //
  @override
  Widget build(BuildContext context) {
    //
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
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
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Agent",
            style: TextStyle(
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
                  showSimpleModal(ListAgent(), context);
                },
                title: const Text("Ajouter"),
                trailing: const Icon(Icons.add),
              ),
              Obx(
                () => Column(
                  children: [
                    journalController.agent['nom'] == null
                        ? Container()
                        : ListTile(
                            leading: SvgPicture.asset(
                              "assets/FluentEmojiHighContrastTropicalFish.svg",
                              height: 30,
                              width: 30,
                            ),
                            title: Text(
                              "${journalController.agent['nom']} ${journalController.agent['postnom']} ${journalController.agent['prenom']}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text.rich(
                              TextSpan(
                                text:
                                    "${journalController.agent['telephone']} \n",
                                children: [
                                  TextSpan(
                                    text: "${journalController.agent['role']}",
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
                            trailing: InkWell(
                              onTap: () {
                                //
                                journalController.agent.value = {};
                                //
                              },
                              child: Icon(
                                Icons.delete,
                                color: Colors.red.shade700,
                              ),
                            ),
                          ),
                  ],
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
            "Montant",
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
            //border: Border.all(color: Colors.grey.shade500, width: 1),
          ),
          child: TextField(
            controller: montant,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Taux",
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
            //border: Border.all(color: Colors.grey.shade500, width: 1),
          ),
          child: TextField(
            controller: taux_,
            enabled: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
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
              "quantite": 1,
              "montant": double.parse(montant.text),
              "taux": taux.value,
              "devise": devises[devise.value],
              "agent":
                  "${journalController.agent['nom']} ${journalController.agent['postnom']} ${journalController.agent['prenom']}",
              "categorie": "Salaire",
            };
            //
            journalController.enregistrement(facture, d);
            //
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
