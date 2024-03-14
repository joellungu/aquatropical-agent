import 'package:aquatropical_agent/pages/expeditions/expeditions_controller.dart';
import 'package:aquatropical_agent/utils/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'expedition_formulaire.dart';
import 'journal_controller.dart';

class Expedition extends StatelessWidget {
  //
  ExpeditionController expeditionController = Get.find();
  //
  JournalController journalController = Get.find();
  //
  TextEditingController certificat = TextEditingController();
  //
  @override
  Widget build(BuildContext context) {
    //
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Numéro du certificat",
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
            controller: certificat,
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
        ElevatedButton(
          onPressed: () {
            //
            Get.to(ExpeditionFormulaire());
          },
          child: Container(
            alignment: Alignment.center,
            width: double.maxFinite,
            height: 40,
            child: Text("Ajouter"),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Obx(
          () => Column(
            children:
                List.generate(expeditionController.expedition.length, (index) {
              //
              Map exp = expeditionController.expedition[index];
              return Container(
                height: 230,
                //color: Colors.blue,
                //width: 300,
                child: Stack(
                  //fit: StackFit.loose,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 200,
                        //width: 250,
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.indigo, width: 1),
                        ),
                        child: Column(
                          children: [
                            //const Divider(),
                            Expanded(
                              flex: 3,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: bloc("BOX", "${exp['box']}"),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: bloc("PACK", "${exp['pack']}"),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child:
                                        bloc("QTY FISH", "${exp['qtyfish']}"),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(),
                            Expanded(
                              flex: 3,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: bloc(
                                        "TOTAL FISH", "${exp['totalfish']}"),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child:
                                        bloc("SIZE / Cm", "${exp['sizeCm']}"),
                                  ),
                                ],
                              ),
                            ),
                            //const Divider(),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                //${saisie['date']}
                                "${exp['poisson']['nom']}",
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Divider(),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                //${saisie['date']}
                                "TOTAL BOX: ${exp['totalBox']}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.all(0),
                        child: InkWell(
                          onTap: () {
                            //
                            expeditionController.expedition.removeAt(index);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              Icons.delete,
                              color: Colors.red.shade900,
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
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
              "montant": 0.0,
              "taux": 0.0,
              "devise": "",
              "expedition": expeditionController.expedition.value,
              "certificat": certificat.text,
              "categorie": "Expédition",
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
            width: double.maxFinite,
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
  Widget bloc(String titre, String valeur) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      width: double.maxFinite,
      //height: 40,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            //height: 15,
            color: Colors.black,
            alignment: Alignment.center,
            child: Text(
              titre,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Container(
            height: 15,
            color: Colors.white,
            alignment: Alignment.center,
            child: Text(
              "$valeur",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
