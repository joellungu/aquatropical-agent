import 'package:aquatropical_agent/pages/expeditions/expeditions_controller.dart';
import 'package:aquatropical_agent/pages/journal/journal_controller.dart';
import 'package:aquatropical_agent/utils/frais_supplementaire.dart';
import 'package:aquatropical_agent/utils/frais_supplementaire_exp.dart';
import 'package:aquatropical_agent/utils/liste_materiels_exp.dart';
import 'package:aquatropical_agent/utils/loader.dart';
import 'package:aquatropical_agent/utils/recherche.dart';
import 'package:aquatropical_agent/utils/vue_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DetailsExpedition extends StatelessWidget {
  //
  Map journal;
  String date;
  //
  DetailsExpedition(this.journal, this.date) {
    roles = [journal['type']];
    //
    //fournisseur = journal['fournisseur'];
    //
    expeditionController.materiels.value = journal['materiels'] ?? [];
    //
    poissons.value = journal['poissons'] ?? [];
    //
    expeditionController.fraisSupplementaire.value =
        journal['fraisSupllementaire'] ?? [];
    //
  }
  //
  //JournalController journalController = Get.find();
  //
  ExpeditionController expeditionController = Get.find();
  //
  //Map fournisseur = {};
  //
  RxList poissons = [].obs;
  //
  //List materiels = [];
  //
  //List frais = [];
  //
  final nom = TextEditingController();
  final postnom = TextEditingController();
  final prenom = TextEditingController();
  final telephone = TextEditingController();
  final adresse = TextEditingController();

  //
  List roles = ["Facture", "Achat materiel", "Perte poissons"];
  RxInt role = 0.obs;
  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        //${journal['titre']}
        title: Text("Details Expédition"),
        centerTitle: true,
        actions: [
          journal['status'] == 1
              ? PopupMenuButton(
                  onSelected: (e) {
                    //
                    if (e == 1) {
                      //
                      Loader.attente();
                      //status
                      journal['status'] = 1;
                      journal['poissons'] = poissons.value;
                      journal['materiels'] =
                          expeditionController.materiels.value;
                      journal['fraisSupllementaire'] =
                          expeditionController.fraisSupplementaire.value;
                      //
                      DateTime d = DateTime.now();
                      String date = "${d.day}-${d.month}-${d.year}";
                      //
                      print("journal: $journal");
                      //
                      expeditionController.updateExpedition(journal, date);
                      //
                    } else {
                      //
                    }
                  },
                  itemBuilder: (c) {
                    return [
                      PopupMenuItem(
                        child: Row(children: [
                          SvgPicture.asset(
                            "assets/MynauiSend.svg",
                            height: 30,
                            width: 30,
                          ),
                          Text("Expédier")
                        ]),
                        value: 1,
                      ),
                      PopupMenuItem(
                        child: Row(
                          children: [
                            Icon(Icons.print),
                            Text(" Imprimer"),
                          ],
                        ),
                        value: 2,
                      ),
                    ];
                  },
                )
              : journal['status'] == 2
                  ? PopupMenuButton(
                      onSelected: (e) {
                        //
                        if (e == 1) {
                          //
                          // Loader.attente();
                          // //status
                          // journal['status'] = 1;
                          // journal['poissons'] = poissons.value;
                          // journal['materiels'] =
                          //     expeditionController.materiels.value;
                          // journal['fraisSupllementaire'] =
                          //     expeditionController.fraisSupplementaire.value;
                          // //
                          // DateTime d = DateTime.now();
                          // String date = "${d.day}-${d.month}-${d.year}";
                          // //
                          // print("journal: $journal");
                          // //
                          // expeditionController.updateExpedition(journal, date);
                          // //
                        } else {
                          //
                        }
                      },
                      itemBuilder: (c) {
                        return [
                          const PopupMenuItem(
                            child: Row(
                              children: [
                                Icon(Icons.print),
                                Text(" Imprimer"),
                              ],
                            ),
                            value: 1,
                          ),
                        ];
                      },
                    )
                  : IconButton(
                      onPressed: () {
                        //
                      },
                      icon: const Icon(Icons.print),
                    ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Titre",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                //height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                //height: 50,
                child: ListTile(
                  leading: const Icon(Icons.title),
                  title: Text(
                    "${journal['titre']}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  //subtitle: Text("${journal['heure']}"),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Date & heure de création",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                //height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                //height: 50,
                child: ListTile(
                  leading: Icon(Icons.timelapse_outlined),
                  title: Text(
                    "${journal['date']}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  subtitle: Text("${journal['heure']}"),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Date d'expédition",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                //height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                //height: 50,
                child: ListTile(
                  leading: const Icon(Icons.calendar_month),
                  title: Text(
                    "${journal['dateExpedition']}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  //subtitle: Text("${journal['heure']}"),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Faris supplementaire",
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
                    journal['status'] == 0
                        ? ListTile(
                            onTap: () {
                              //
                              showSimpleModal(
                                  FraisSupplementaireExp(), context);
                            },
                            title: const Text("Ajouter"),
                            trailing: const Icon(Icons.add),
                          )
                        : Container(),
                    Obx(
                      () => Column(
                        children: List.generate(
                          expeditionController.fraisSupplementaire.length,
                          (index) {
                            Map f =
                                expeditionController.fraisSupplementaire[index];
                            return ListTile(
                              leading: SvgPicture.asset(
                                "assets/SolarBoxLinear.svg",
                                height: 30,
                                width: 30,
                              ),
                              title: Text(
                                "${f['type']} / ${f['nom']}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("${f['montant']} "),
                                  Text(
                                    "${f['devise']} ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.indigo),
                                  ),
                                ],
                              ),
                              trailing: journal['status'] == 0
                                  ? InkWell(
                                      onTap: () {
                                        //
                                        expeditionController.fraisSupplementaire
                                            .removeAt(index);
                                        //
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    )
                                  : Container(
                                      height: 0,
                                      width: 0,
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
              Container(
                height: journal['commandes'].length * 66.66666,
                child: VueTable(journal, journal['commandes'], date),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(flex: 4, child: Container()),
                  Expanded(
                    flex: 4,
                    child: journal['status'] == 0
                        ? ElevatedButton(
                            onPressed: () {
                              //
                              Loader.attente();
                              //status
                              journal['status'] = 0;
                              journal['poissons'] = poissons.value;
                              journal['materiels'] =
                                  expeditionController.materiels.value;
                              journal['fraisSupllementaire'] =
                                  expeditionController
                                      .fraisSupplementaire.value;
                              //
                              //DateTime d = DateTime.now();
                              //String date = "${d.day}-${d.month}-${d.year}";
                              //
                              print("journal: $journal");
                              //
                              expeditionController.updateExpedition(
                                  journal, date);
                              //
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.blue.shade700),
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
                                color: Colors.blue.shade700,
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
                          )
                        : Container(),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 4,
                    child: journal['status'] == 0
                        ? ElevatedButton(
                            onPressed: () {
                              //
                              Loader.attente();
                              //status
                              journal['status'] = 0;
                              journal['poissons'] = poissons.value;
                              journal['materiels'] =
                                  expeditionController.materiels.value;
                              journal['fraisSupllementaire'] =
                                  expeditionController
                                      .fraisSupplementaire.value;
                              //
                              //DateTime d = DateTime.now();
                              //String date = "${d.day}-${d.month}-${d.year}";
                              //
                              print("journal: $journal");
                              //
                              journal['status'] = 1;
                              //
                              expeditionController.updateExpedition(
                                  journal, date);
                              //
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.green.shade700),
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
                                "Expedier",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ),
                  Expanded(flex: 4, child: Container()),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
