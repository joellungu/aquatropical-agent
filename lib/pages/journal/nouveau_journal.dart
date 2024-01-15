import 'package:aquatropical_agent/pages/journal/journal_controller.dart';
import 'package:aquatropical_agent/utils/liste_poissons.dart';
import 'package:aquatropical_agent/utils/loader.dart';
import 'package:aquatropical_agent/utils/recherche.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

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
  List roles = ["Facture", "Achat", "Perte", "Entretien"];
  RxInt role = 0.obs;
  //
  @override
  Widget build(BuildContext context) {
    //
    Map poisson = {};
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
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Poissons",
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
                      title: Text("Ajouter poisson"),
                      trailing: Icon(Icons.add),
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
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
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
                  "Produits",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              TextField(
                controller: postnom,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  prefixIcon: Container(
                    padding: const EdgeInsets.all(5),
                    height: 20,
                    width: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
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
              TextField(
                controller: prenom,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  prefixIcon: Container(
                    padding: const EdgeInsets.all(5),
                    height: 20,
                    width: 20,
                  ),
                ),
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
                  Map fournisseur = {
                    "nom": nom.text,
                    "postnom": postnom.text,
                    "prenom": prenom.text,
                    "adresse": adresse.text,
                    "telephone": telephone.text,
                    "email": "",
                    "type": roles[role.value],
                    "typeIndex": role.value,
                    "status": 0,
                  };
                  /**
                   * public String nom;
                    public String postnom;
                    public String prenom;
                    public String telephone;
                    public String mdp;
                    public String role;
                    public int roleIndex;
                    public String adresse;
                    public int status;
                   */
                  //
                  DateTime date = DateTime.now();
                  //
                  String d = "${date.day}-${date.month}-${date.year}";
                  //
                  journalController.enregistrement(fournisseur, d);
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
                    "Ajouter",
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
