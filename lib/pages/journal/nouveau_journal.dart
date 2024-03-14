import 'dart:async';
import 'dart:ui';

import 'package:aquatropical_agent/pages/journal/Facture_materiel.dart';
import 'package:aquatropical_agent/pages/journal/Perte_poisson.dart';
import 'package:aquatropical_agent/pages/journal/journal_controller.dart';
import 'package:aquatropical_agent/utils/frais_supplementaire.dart';
import 'package:aquatropical_agent/utils/liste_fournisseur.dart';
import 'package:aquatropical_agent/utils/liste_materiels.dart';
import 'package:aquatropical_agent/utils/liste_poissons.dart';
import 'package:aquatropical_agent/utils/loader.dart';
import 'package:aquatropical_agent/utils/recherche.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'Entree_caisse.dart';
import 'Loyer.dart';
import 'autres_depenses.dart';
import 'expedition.dart';
import 'facture_poisson.dart';
import 'prestation_service.dart';
import 'salaire.dart';
import 'soins_medicaux.dart';
import 'transport.dart';
import 'vie_kins.dart';
import 'xch.dart';

class NouveauJournal extends StatelessWidget {
  //
  JournalController journalController = Get.find();
  //
  final nom = TextEditingController();
  final postnom = TextEditingController();
  final prenom = TextEditingController();
  final telephone = TextEditingController();
  final adresse = TextEditingController();
  //
  //
  var box = GetStorage();
  //
  List roles = [
    "Facture Poisson",
    "Facture Materiel",
    "Entrée Caisse",
    //"Achat materiel",
    "Perte poissons",
    "Salaire",
    "Prestation de service",
    "Soins médicaux",
    "Loyer",
    "Autres depenses",
    "Transport",
    "Vie Kin",
    "XCH",
    "Expédition",
  ];
  RxInt role = 0.obs;
  //
  RxBool fraisVue = false.obs;
  //
  RxBool facturePoisson = false.obs;
  RxBool factureMateriel = false.obs;
  RxBool entreeCaisse = false.obs;
  RxBool achatMateriel = false.obs;
  RxBool pertePoissons = false.obs;
  RxBool salaire = false.obs;
  RxBool prestationService = false.obs;
  RxBool soinsMedicaux = false.obs;
  RxBool loyer = false.obs;
  RxBool autresDepenses = false.obs;
  RxBool transport = false.obs;
  RxBool vieKin = false.obs;
  RxBool xch = false.obs;
  RxBool expedition = false.obs;
  //
  RxBool materielVue = false.obs;
  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nouveau journal"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.maxFinite,
            decoration: const BoxDecoration(
              //color: Colors.white,
              image: DecorationImage(
                image: AssetImage("assets/pngegg.png"),
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
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Type",
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
                            Border.all(color: Colors.grey.shade500, width: 1)),
                    child: Obx(
                      () => DropdownButtonHideUnderline(
                        child: DropdownButton(
                          isExpanded: true,
                          padding: const EdgeInsets.only(left: 10),
                          value: role.value,
                          onChanged: (e) {
                            //
                            role.value = e as int;
                            //
                            journalController.fournisseur.value = {};
                            //
                            journalController.materiels.value = [];
                            //
                            journalController.poissons.value = [];
                            //
                            journalController.fraisSupplementaire.value = {};

                            //
                            if ("${roles[e]}" == "Facture Poisson") {
                              facturePoisson.value = true;
                              factureMateriel.value = false;
                              entreeCaisse.value = false;
                              achatMateriel.value = false;
                              pertePoissons.value = false;
                              salaire.value = false;
                              prestationService.value = false;
                              soinsMedicaux.value = false;
                              loyer.value = false;
                              autresDepenses.value = false;
                              transport.value = false;
                              vieKin.value = false;
                              xch.value = false;
                              expedition.value = false;
                              materielVue.value = false;
                              //
                            } else if ("${roles[e]}" == "Facture Materiel") {
                              facturePoisson.value = false;
                              factureMateriel.value = true;
                              entreeCaisse.value = false;
                              achatMateriel.value = false;
                              pertePoissons.value = false;
                              salaire.value = false;
                              prestationService.value = false;
                              soinsMedicaux.value = false;
                              loyer.value = false;
                              autresDepenses.value = false;
                              transport.value = false;
                              vieKin.value = false;
                              xch.value = false;
                              expedition.value = false;
                              materielVue.value = false;
                              //
                            } else if ("${roles[e]}" == "Entrée Caisse") {
                              facturePoisson.value = false;
                              factureMateriel.value = false;
                              entreeCaisse.value = true;
                              achatMateriel.value = false;
                              pertePoissons.value = false;
                              salaire.value = false;
                              prestationService.value = false;
                              soinsMedicaux.value = false;
                              loyer.value = false;
                              autresDepenses.value = false;
                              transport.value = false;
                              vieKin.value = false;
                              xch.value = false;
                              expedition.value = false;
                              materielVue.value = false;
                              //
                            } else if ("${roles[e]}" == "Achat materiel") {
                              facturePoisson.value = false;
                              factureMateriel.value = false;
                              entreeCaisse.value = false;
                              achatMateriel.value = true;
                              pertePoissons.value = false;
                              salaire.value = false;
                              prestationService.value = false;
                              soinsMedicaux.value = false;
                              loyer.value = false;
                              autresDepenses.value = false;
                              transport.value = false;
                              vieKin.value = false;
                              xch.value = false;
                              expedition.value = false;
                              materielVue.value = false;
                              //
                            } else if ("${roles[e]}" == "Perte poissons") {
                              facturePoisson.value = false;
                              factureMateriel.value = false;
                              entreeCaisse.value = false;
                              achatMateriel.value = false;
                              pertePoissons.value = true;
                              salaire.value = false;
                              prestationService.value = false;
                              soinsMedicaux.value = false;
                              loyer.value = false;
                              autresDepenses.value = false;
                              transport.value = false;
                              vieKin.value = false;
                              xch.value = false;
                              expedition.value = false;
                              materielVue.value = false;
                              //
                            } else if ("${roles[e]}" == "Salaire") {
                              facturePoisson.value = false;
                              factureMateriel.value = false;
                              entreeCaisse.value = false;
                              achatMateriel.value = false;
                              pertePoissons.value = false;
                              salaire.value = true;
                              prestationService.value = false;
                              soinsMedicaux.value = false;
                              loyer.value = false;
                              autresDepenses.value = false;
                              transport.value = false;
                              vieKin.value = false;
                              xch.value = false;
                              expedition.value = false;
                              materielVue.value = false;
                              //
                            } else if ("${roles[e]}" ==
                                "Prestation de service") {
                              facturePoisson.value = false;
                              factureMateriel.value = false;
                              entreeCaisse.value = false;
                              achatMateriel.value = false;
                              pertePoissons.value = false;
                              salaire.value = false;
                              prestationService.value = true;
                              soinsMedicaux.value = false;
                              loyer.value = false;
                              autresDepenses.value = false;
                              transport.value = false;
                              vieKin.value = false;
                              xch.value = false;
                              expedition.value = false;
                              materielVue.value = false;
                              //
                            } else if ("${roles[e]}" == "Soins médicaux") {
                              facturePoisson.value = false;
                              factureMateriel.value = false;
                              entreeCaisse.value = false;
                              achatMateriel.value = false;
                              pertePoissons.value = false;
                              salaire.value = false;
                              prestationService.value = false;
                              soinsMedicaux.value = true;
                              loyer.value = false;
                              autresDepenses.value = false;
                              transport.value = false;
                              vieKin.value = false;
                              xch.value = false;
                              expedition.value = false;
                              materielVue.value = false;
                              //
                            } else if ("${roles[e]}" == "Loyer") {
                              facturePoisson.value = false;
                              factureMateriel.value = false;
                              entreeCaisse.value = false;
                              achatMateriel.value = false;
                              pertePoissons.value = false;
                              salaire.value = false;
                              prestationService.value = false;
                              soinsMedicaux.value = false;
                              loyer.value = true;
                              autresDepenses.value = false;
                              transport.value = false;
                              vieKin.value = false;
                              xch.value = false;
                              expedition.value = false;
                              materielVue.value = false;
                              //
                            } else if ("${roles[e]}" == "Autres depenses") {
                              facturePoisson.value = false;
                              factureMateriel.value = false;
                              entreeCaisse.value = false;
                              achatMateriel.value = false;
                              pertePoissons.value = false;
                              salaire.value = false;
                              prestationService.value = false;
                              soinsMedicaux.value = false;
                              loyer.value = false;
                              autresDepenses.value = true;
                              transport.value = false;
                              vieKin.value = false;
                              xch.value = false;
                              expedition.value = false;
                              materielVue.value = false;
                              //
                            } else if ("${roles[e]}" == "Transport") {
                              facturePoisson.value = false;
                              factureMateriel.value = false;
                              entreeCaisse.value = false;
                              achatMateriel.value = false;
                              pertePoissons.value = false;
                              salaire.value = false;
                              prestationService.value = false;
                              soinsMedicaux.value = false;
                              loyer.value = false;
                              autresDepenses.value = false;
                              transport.value = true;
                              vieKin.value = false;
                              xch.value = false;
                              expedition.value = false;
                              materielVue.value = false;
                              //
                            } else if ("${roles[e]}" == "Vie Kin") {
                              facturePoisson.value = false;
                              factureMateriel.value = false;
                              entreeCaisse.value = false;
                              achatMateriel.value = false;
                              pertePoissons.value = false;
                              salaire.value = false;
                              prestationService.value = false;
                              soinsMedicaux.value = false;
                              loyer.value = false;
                              autresDepenses.value = false;
                              transport.value = false;
                              vieKin.value = true;
                              xch.value = false;
                              expedition.value = false;
                              materielVue.value = false;
                              //
                            } else if ("${roles[e]}" == "XCH") {
                              facturePoisson.value = false;
                              factureMateriel.value = false;
                              entreeCaisse.value = false;
                              achatMateriel.value = false;
                              pertePoissons.value = false;
                              salaire.value = false;
                              prestationService.value = false;
                              soinsMedicaux.value = false;
                              loyer.value = false;
                              autresDepenses.value = false;
                              transport.value = false;
                              vieKin.value = false;
                              xch.value = true;
                              expedition.value = false;
                              materielVue.value = false;
                              //
                            } else if ("${roles[e]}" == "Expédition") {
                              facturePoisson.value = false;
                              factureMateriel.value = false;
                              entreeCaisse.value = false;
                              achatMateriel.value = false;
                              pertePoissons.value = false;
                              salaire.value = false;
                              prestationService.value = false;
                              soinsMedicaux.value = false;
                              loyer.value = false;
                              autresDepenses.value = false;
                              transport.value = false;
                              vieKin.value = false;
                              xch.value = false;
                              expedition.value = true;
                              materielVue.value = false;
                              //
                            } else {
                              facturePoisson.value = false;
                              factureMateriel.value = false;
                              entreeCaisse.value = false;
                              achatMateriel.value = false;
                              pertePoissons.value = false;
                              salaire.value = false;
                              prestationService.value = false;
                              soinsMedicaux.value = false;
                              loyer.value = false;
                              autresDepenses.value = false;
                              transport.value = false;
                              vieKin.value = false;
                              xch.value = false;
                              expedition.value = false;
                              materielVue.value = true;
                              //
                            }
                          },
                          items: List.generate(
                            roles.length,
                            (index) => DropdownMenuItem(
                              value: index,
                              child: Text(
                                "${roles[index]}",
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
                  Obx(() =>
                      facturePoisson.value ? FacturePoisson() : Container()),
                  Obx(() =>
                      factureMateriel.value ? FactureMateriel() : Container()),
                  Obx(() => entreeCaisse.value ? EntreeCaisse() : Container()),
                  Obx(() => pertePoissons.value ? PertePoisson() : Container()),
                  Obx(() => salaire.value ? Salaire() : Container()),
                  Obx(() =>
                      soinsMedicaux.value ? SoinsMedicaux() : Container()),
                  Obx(() => prestationService.value
                      ? PrestationDeService()
                      : Container()),
                  Obx(() => loyer.value ? Loyer() : Container()),
                  Obx(() =>
                      autresDepenses.value ? AutresDepenses() : Container()),
                  Obx(() => transport.value ? Transport() : Container()),
                  Obx(() => vieKin.value ? VieKin() : Container()),
                  //
                  Obx(() {
                    //Flutter.delay(const Duration(seconds: 1));
                    //Timer(const Duration(seconds: 1), () {});
                    if (xch.value) {
                      return Xch();
                    } else {
                      return Container();
                    }
                  }),
                  Obx(() => expedition.value ? Expedition() : Container()),

                  const SizedBox(
                    height: 10,
                  ),
                  //
                  //_____________________________________________
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
