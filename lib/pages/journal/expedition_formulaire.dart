import 'dart:ui';

import 'package:aquatropical_agent/utils/liste_poissons.dart';
import 'package:aquatropical_agent/utils/recherche.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../expeditions/expeditions_controller.dart';
import 'journal_controller.dart';

class ExpeditionFormulaire extends StatelessWidget {
  //
  TextEditingController box = TextEditingController();
  TextEditingController pack = TextEditingController();
  TextEditingController qtyfish = TextEditingController();
  TextEditingController totalfish = TextEditingController();
  TextEditingController sizeCm = TextEditingController();
  TextEditingController totalBox = TextEditingController();
  //
  JournalController journalController = Get.find();
  //
  ExpeditionController expeditionController = Get.find();

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.maxFinite,
            decoration: const BoxDecoration(
              //color: Colors.white,
              image: DecorationImage(
                image: AssetImage("assets/pngegg (1).png"),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
              child: Opacity(
                opacity: 0.9,
                child: Container(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          ListView(
            padding: EdgeInsets.all(10),
            children: [
              const SizedBox(
                height: 10,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "BOX (#)",
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
                  controller: box,
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
                  "PACK",
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
                  controller: pack,
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
                  "QTY FISH",
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
                  controller: qtyfish,
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
                  "TOTAL FISH",
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
                  controller: totalfish,
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
                  "SIZE CM",
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
                  controller: sizeCm,
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
                  "Poisson",
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
                    Obx(() {
                      if (journalController.poisson['nom'] != null) {
                        //
                        //qtyfish.text = journalController.poisson['quantite'];
                        //
                        return ListTile(
                          leading: SvgPicture.asset(
                            "assets/FluentEmojiHighContrastTropicalFish.svg",
                            height: 30,
                            width: 30,
                          ),
                          title: Text(
                            "${journalController.poisson['nom']}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("${journalController.poisson['prixUSD']} "),
                              const Text(
                                "x ",
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                "${journalController.poisson['quantite']} = ",
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                "${double.parse(journalController.poisson['quantite']) * journalController.poisson['prixUSD']} ",
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
                              journalController.poisson.value = {};
                              //
                            },
                            child: Icon(
                              Icons.delete,
                              color: Colors.red.shade700,
                            ),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    })
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "TOTAL BOX",
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
                  controller: totalBox,
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
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  /*
              TextEditingController box = TextEditingController();
  TextEditingController pack = TextEditingController();
  TextEditingController qtyfish = TextEditingController();
  TextEditingController totalfish = TextEditingController();
  TextEditingController sizeCm = TextEditingController();
  TextEditingController totalBox = TextEditingController();
              */

                  //
                  Map exp = {
                    "box": box.text,
                    "pack": pack.text,
                    "qtyfish": qtyfish.text,
                    "totalfish": totalfish.text,
                    "sizeCm": sizeCm.text,
                    "totalBox": totalBox.text,
                    "poisson": journalController.poisson,
                  };
                  //
                  expeditionController.expedition.add(exp);
                  //
                  Get.back();
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
          )
        ],
      ),
    );
  }
}
