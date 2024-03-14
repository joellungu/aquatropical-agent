import 'package:aquatropical_agent/pages/journal/journal_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FraisSupplementaire extends StatelessWidget {
  //
  final montant = TextEditingController();
  final postnom = TextEditingController();
  //
  JournalController journalController = Get.find();
  //
  List roles = ["Transport", "Autre"];
  RxInt role = 0.obs;
  //
  List devises = ["USD", "CDF"];
  RxInt devise = 0.obs;
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(
                height: 10,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Frais",
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
                  "Montant",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              TextField(
                controller: montant,
                keyboardType: TextInputType.number,
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
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
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
                  Map frais = {
                    "montant": montant.text,
                    "devise": devises[devise.value],
                    "type": roles[role.value],
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
                  journalController.fraisSupplementaire.value = frais;
                  //
                  Get.back();
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
