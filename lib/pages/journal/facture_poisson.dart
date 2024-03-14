import 'package:aquatropical_agent/utils/frais_supplementaire.dart';
import 'package:aquatropical_agent/utils/liste_fournisseur.dart';
import 'package:aquatropical_agent/utils/liste_poissons.dart';
import 'package:aquatropical_agent/utils/loader.dart';
import 'package:aquatropical_agent/utils/recherche.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uuid/uuid.dart';
import 'journal_controller.dart';

class FacturePoisson extends StatelessWidget {
  //
  RxDouble taux = 0.0.obs;
  //
  var uuid = Uuid();
  //
  FacturePoisson() {
    //
    taux.value = (box.read("taux") + 0.0) ?? 0.0;
  }

  RxInt devise = 0.obs;
  RxList devises = ["USD", "CDF"].obs;
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

    //
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Fournisseurs",
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
                  showSimpleModal(ListFournisseurs(), context);
                },
                title: const Text("Ajouter"),
                trailing: const Icon(Icons.add),
              ),
              Obx(
                () => journalController.fournisseur['nom'] == null
                    ? Container()
                    : ListTile(
                        leading: SvgPicture.asset(
                          "assets/GalaPortrait1.svg",
                          height: 30,
                          width: 30,
                        ),
                        title: Text(
                          "${journalController.fournisseur['nom']} ${journalController.fournisseur['postnom']} ${journalController.fournisseur['prenom']}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: RichText(
                          text: TextSpan(
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                  text:
                                      "${journalController.fournisseur['telephone']} "),
                              TextSpan(
                                text:
                                    "${journalController.fournisseur['type']}\n",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              TextSpan(
                                text:
                                    "${journalController.fournisseur['adresse']}\n",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15,
                                    color: Colors.indigo),
                              ),
                            ],
                          ),
                        ),
                        trailing: InkWell(
                          onTap: () {
                            //
                            journalController.fournisseur.value = {};
                            //
                          },
                          child: Icon(
                            Icons.delete,
                            color: Colors.red.shade700,
                          ),
                        ),
                      ),
              ),
            ],
          ),
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
        const SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Obx(
            () => Text(
              "Poissons (${taux.value} = 1\$)",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
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
                            const Text(
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
                            const Text(
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
          height: 10,
        ),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Frais supplementaire",
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
                  showSimpleModal(FraisSupplementaire(), context);
                },
                title: const Text("Ajouter"),
                trailing: const Icon(Icons.add),
              ),
              Obx(
                () => journalController.fraisSupplementaire['montant'] != null
                    ? ListTile(
                        leading: SvgPicture.asset(
                          "assets/SolarBoxLinear.svg",
                          height: 30,
                          width: 30,
                        ),
                        title: Text(
                          "${journalController.fraisSupplementaire['type']}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                                "${journalController.fraisSupplementaire['montant']} "),
                            Text(
                              "${journalController.fraisSupplementaire['devise']} ",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.indigo,
                              ),
                            ),
                          ],
                        ),
                        trailing: InkWell(
                          onTap: () {
                            //
                            journalController.fraisSupplementaire.value = {};
                            //
                          },
                          child: Icon(
                            Icons.delete,
                            color: Colors.red.shade700,
                          ),
                        ),
                      )
                    : Container(),
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
            String idFacture = uuid.v1();
            //
            DateTime date = DateTime.now();
            //
            Map agent = box.read("user") ?? {};
            //
            String d = "${date.day}-${date.month}-${date.year}";
            String h = "${date.hour}:${date.minute}";
            // //
            List journaux = [];

            //
            // Map facture = {
            //   "date": d,
            //   "heure": h,
            //   "montant": 0.0,
            //   "remarque": "",
            //   "quantite": 1,
            //   "taux": taux.value,
            //   "devise": devises[devise.value],
            //   "fournisseur": journalController.fournisseur.value,
            //   "agent": agent,
            //   "poissons": journalController.poissons.value,
            //   "frais": journalController.fraisSupplementaire.value,
            //   "categorie": "Facture Poisson",
            // };
            //
            journalController.poissons.forEach((p) {
              //
              journaux.add({
                "date": d,
                "heure": h,
                //"entreeUSD": double.parse(entreeUSD.text),
                "montant": devises[devise.value] == "USD"
                    ? p['prixUSD']
                    : p['prixCDF'],
                "quantite": p['quantite'],
                "taux": taux.value,
                "devise": devises[devise.value],
                "categorie": "Facture Poisson",
                "remarque":
                    "${p['id']},Achate ${p['nom']} de chez ${journalController.fournisseur['nom']} ${journalController.fournisseur['postnom']} ${journalController.fournisseur['prenom']} ",
                "idAgent": agent['id'],
                "idFacture": idFacture,
                "idFournisseur": journalController.fournisseur['id'],
              });
            });
            /**
             * public Long idAgent;
    public String idFacture;
             */
            //
            //
            journaux.add({
              "date": d,
              "heure": h,
              //"entreeUSD": double.parse(entreeUSD.text),
              "montant": journalController.fraisSupplementaire['montant'],
              "quantite": 1,
              "taux": taux.value,
              "devise": journalController.fraisSupplementaire['devise'],
              "categorie": "Frais supplementaire",
              "remarque": "${journalController.fraisSupplementaire['type']}",
              "idAgent": agent['id'],
              "idFacture": idFacture,
              "idFournisseur": journalController.fournisseur['id'],
            });
            //
            print("journaux: $journaux");
            //
            journalController.enregistrement2(journaux, d);
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

  //
}
