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
  List roles = ["Facture", "Achat materiel", "Perte poissons"];
  RxInt role = 0.obs;
  //
  RxBool fraisVue = false.obs;
  //
  RxBool fournisseurVue = false.obs;
  //
  RxBool poissonVue = false.obs;
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
      body: SingleChildScrollView(
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
                    border: Border.all(color: Colors.grey.shade500, width: 1)),
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
                        journalController.fraisSupplementaire.value = [];

                        //
                        if ("${roles[e]}" == "Facture") {
                          fournisseurVue.value = true;
                          poissonVue.value = true;
                          fraisVue.value = true;
                          materielVue.value = false;
                        } else if ("${roles[e]}" == "Achat materiel") {
                          fournisseurVue.value = false;
                          poissonVue.value = false;
                          fraisVue.value = true;
                          materielVue.value = true;
                        } else {
                          fournisseurVue.value = false;
                          poissonVue.value = true;
                          fraisVue.value = false;
                          materielVue.value = false;
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
              Obx(
                () => fournisseurVue.value
                    ? const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Fournisseurs",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      )
                    : Container(),
              ),
              Obx(
                () => fournisseurVue.value
                    ? Container(
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
                                          journalController.fournisseur.value =
                                              {};
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
                      )
                    : Container(),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(
                () => poissonVue.value
                    ? const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Poissons",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      )
                    : Container(),
              ),
              Obx(
                () => poissonVue.value
                    ? Container(
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
                                    Map poisson =
                                        journalController.poissons[index];
                                    return ListTile(
                                      leading: SvgPicture.asset(
                                        "assets/FluentEmojiHighContrastTropicalFish.svg",
                                        height: 30,
                                        width: 30,
                                      ),
                                      title: Text(
                                        "${poisson['nom']}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text("${poisson['prix']} "),
                                          Text(
                                            "x ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text(
                                            "${poisson['quantite']} = ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text(
                                            "${double.parse(poisson['quantite']) * poisson['prix']} ",
                                            style: TextStyle(
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
                                          journalController.poissons
                                              .removeAt(index);
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
                      )
                    : Container(),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(
                () => materielVue.value
                    ? const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Produits & Materiels",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      )
                    : Container(),
              ),
              Obx(
                () => materielVue.value
                    ? Container(
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
                                showSimpleModal(ListMateriels(), context);
                              },
                              title: const Text("Ajouter"),
                              trailing: const Icon(Icons.add),
                            ),
                            Obx(
                              () => Column(
                                children: List.generate(
                                  journalController.materiels.length,
                                  (index) {
                                    Map materiel =
                                        journalController.materiels[index];
                                    return ListTile(
                                      leading: SvgPicture.asset(
                                        "assets/SolarBoxLinear.svg",
                                        height: 30,
                                        width: 30,
                                      ),
                                      title: Text(
                                        "${materiel['nom']}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text("${materiel['prix']} "),
                                          Text(
                                            "x ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text(
                                            "${materiel['quantite']} = ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text(
                                            "${double.parse(materiel['quantite']) * materiel['prix']} ",
                                            style: TextStyle(
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
                                          journalController.materiels
                                              .removeAt(index);
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
                      )
                    : Container(),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(
                () => fraisVue.value
                    ? const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Faris supplementaire",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      )
                    : Container(),
              ),
              Obx(
                () => fraisVue.value
                    ? Container(
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
                              () => Column(
                                children: List.generate(
                                  journalController.fraisSupplementaire.length,
                                  (index) {
                                    Map frais = journalController
                                        .fraisSupplementaire[index];
                                    return ListTile(
                                      leading: SvgPicture.asset(
                                        "assets/SolarBoxLinear.svg",
                                        height: 30,
                                        width: 30,
                                      ),
                                      title: Text(
                                        "${frais['type']}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text("${frais['montant']} "),
                                          Text(
                                            "${frais['devise']} ",
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
                                          journalController.fraisSupplementaire
                                              .removeAt(index);
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
                      )
                    : Container(),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Loader.attente();
                  /**
                   * public String nom;
                    public String postnom;
                    public String prenom;
                    public String adresse;
                    public String telephone;
                    public String email;
                    public int type;
                    public String typeIndex;
                    public int status;
                   */
                  //
                  DateTime date = DateTime.now();
                  //
                  String d = "${date.day}-${date.month}-${date.year}";
                  String h = "${date.hour}:${date.minute}";
                  //
                  Map user = box.read("user") ?? {};
                  //
                  Map facture = {
                    "type": roles[role.value],
                    "idAgent": user['id'],
                    "date": d,
                    "heure": h,
                    "poissons": journalController.poissons.value,
                    "materiels": journalController.materiels.value,
                    "fournisseur": journalController.fournisseur.value,
                    "fraisSupllementaire":
                        journalController.fraisSupplementaire.value,
                  };
                  /**
                   public String type;

                   public Long idAgent;
    public String date;
    public String heure;
    @ElementCollection
    public List<PoissonFac> poissons;

    @ElementCollection
    public List<MaterielFac> materiels;

    public HashMap fournisseur;
                   */
                  //

                  //
                  journalController.enregistrement(facture, d);
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
            ],
          ),
        ),
      ),
    );
  }
}
