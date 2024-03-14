import 'package:aquatropical_agent/utils/frais_supplementaire.dart';
import 'package:aquatropical_agent/utils/liste_fournisseur.dart';
import 'package:aquatropical_agent/utils/liste_poissons.dart';
import 'package:aquatropical_agent/utils/loader.dart';
import 'package:aquatropical_agent/utils/recherche.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'journal_controller.dart';

class PertePoisson extends StatelessWidget {
  //
  RxDouble taux = 0.0.obs;
  //
  PertePoisson() {
    //
    taux.value = box.read("taux") ?? 0;
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
  @override
  Widget build(BuildContext context) {
    //
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Poissons perdu(s)",
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
                  showSimpleModal(ListPoissons(), context);
                },
                title: const Text("Ajouter"),
                trailing: const Icon(Icons.add),
              ),
              Obx(
                () => Column(
                  children: List.generate(
                    journalController.poissons.length,
                    (index) {
                      Map poisson = journalController.poissons[index];
                      return ListTile(
                        leading: SvgPicture.asset(
                          "assets/FluentEmojiHighContrastTropicalFish.svg",
                          height: 30,
                          width: 30,
                        ),
                        title: Text(
                          "${poisson['nom']}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("${poisson['prixUSD']} "),
                            Text(
                              "x ",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              "${poisson['quantite']} = ",
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              "${double.parse(poisson['quantite']) * poisson['prixUSD']} ",
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
                            journalController.poissons.removeAt(index);
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
            /**
             * public String date;
    public String heure;
    public double entreeUSD;
    public double entreeCDF;
    public double taux;
    public double depenseUSD;
    public double depenseCDF;
    @Lob
    public String remarque;
             */
            // //

            //
            Map facture = {
              "date": d,
              "heure": h,
              "montant": 0.0,
              "taux": taux.value,
              "quantite": 1,
              "fournisseur": journalController.fournisseur.value,
              "poissons": journalController.poissons.value,
              //"frais": journalController.fraisSupplementaire.value,
              "categorie": "Perte poissons",
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
