import 'package:aquatropical_agent/pages/journal/journal_controller.dart';
import 'package:aquatropical_agent/utils/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Xch extends StatelessWidget {
  //
  RxDouble taux = 0.0.obs;
  //
  RxInt devise = 0.obs;
  RxList devises = ["USD", "CDF"].obs;
  //
  JournalController journalController = Get.find();
  TextEditingController montant = TextEditingController();
  TextEditingController taux_ = TextEditingController();
  //
  Xch() {
    //
    taux.value = (box.read("taux") + 0.0) ?? 0;
    taux_.text = "${taux.value}";
  }
  //
  var box = GetStorage();
  //
  @override
  Widget build(BuildContext context) {
    //
    return Column(
      children: [
        FutureBuilder(
            future: journalController.getSolde(),
            builder: (c, t) {
              //

              //
              if (t.hasData) {
                //
                Map solde = t.data as Map;
                print("solde: $solde");
                //
                return Column(
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
                        border:
                            Border.all(color: Colors.grey.shade500, width: 1),
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
                        "",
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
                      child: Obx(
                        () => TextField(
                          controller: montant,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            suffixText: devise.value == 0 ? "En CDF" : "En USD",
                            //prefixText: "",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
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
                          "categorie": "XCH",
                        };
                        //
                        journalController.enregistrement(facture, d);
                        //
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green.shade700),
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
              } else if (t.hasError) {
                return Scaffold();
              }
              return Center(
                child: Container(
                  height: 40,
                  width: 40,
                  child: const CircularProgressIndicator(),
                ),
              );
            })
      ],
    );
  }
  //
}
