import 'package:aquatropical_agent/utils/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'journal_controller.dart';

class Transport extends StatelessWidget {
  //
  RxDouble taux = 0.0.obs;
  //
  RxInt devise = 0.obs;
  RxList devises = ["USD", "CDF"].obs;
  //
  JournalController journalController = Get.find();
  //
  Transport() {
    //
    taux.value = (box.read("taux") + 0.0) ?? 0;
    taux_.text = "${taux.value}";
  }

  //
  var box = GetStorage();
  //
  TextEditingController motif = TextEditingController();
  TextEditingController montant = TextEditingController();
  TextEditingController taux_ = TextEditingController();
  //

  @override
  Widget build(BuildContext context) {
    //
    return Container(
      padding: const EdgeInsets.all(0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
            height: 10,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Motif (Détails)",
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
              controller: motif,
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

              //motif
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
                "motif": motif.text,
                "categorie": "Transport",
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
      ),
    );
  }
  //
}
