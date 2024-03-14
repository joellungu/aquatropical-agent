import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DetailsCommande extends StatelessWidget {
  //
  Map journal;
  //
  int i;
  //
  TextEditingController box = TextEditingController();
  //
  TextEditingController pack = TextEditingController();
  //
  TextEditingController quantite = TextEditingController();
  //
  TextEditingController poisson = TextEditingController();

  //
  DetailsCommande(this.journal, this.i) {
    //
    print("journal: ${journal['commandes'][i]}");
  }
  //
  RxInt statuInt = 1.obs;
  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        title: Text("Details commande n°${i + 1}"),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          Card(
            elevation: 0,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //${journal['']}
                  ListTile(
                    leading: SvgPicture.asset(
                      "assets/SolarBoxLinear.svg",
                      height: 30,
                      width: 30,
                      color: Colors.indigo,
                    ),
                    title: const Text("Nombre de Box"),
                    subtitle: Text(
                      "${journal['commandes'][i]['box']}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: TextField(
                            controller: box,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: ElevatedButton(
                          onPressed: () {
                            //
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            child: const Text("Modifier"),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Card(
            elevation: 0,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //${journal['']}
                  ListTile(
                    leading: SvgPicture.asset(
                      "assets/SolarBoxLinear.svg",
                      height: 30,
                      width: 30,
                      color: Colors.indigo,
                    ),
                    title: const Text("Nombre de Pack"),
                    subtitle: Text(
                      "${journal['commandes'][i]['pack']}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: TextField(
                            controller: pack,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: ElevatedButton(
                          onPressed: () {
                            //
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            child: const Text("Modifier"),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Card(
            elevation: 0,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //${journal['']}
                  ListTile(
                    leading: SvgPicture.asset(
                      "assets/SolarBoxLinear.svg",
                      height: 30,
                      width: 30,
                      color: Colors.indigo,
                    ),
                    title: const Text("Quantité de poisson (qtyFish)"),
                    subtitle: Text(
                      "${journal['commandes'][i]['qtyFish']}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: TextField(
                            controller: quantite,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: ElevatedButton(
                          onPressed: () {
                            //
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            child: const Text("Modifier"),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Card(
            elevation: 0,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //${journal['']}
                  ListTile(
                    leading: SvgPicture.asset(
                      "assets/SolarBoxLinear.svg",
                      height: 30,
                      width: 30,
                      color: Colors.indigo,
                    ),
                    title: const Text("Total poisson (TotalFish)"),
                    subtitle: Text(
                      "${journal['commandes'][i]['totalFish']}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: TextField(
                            controller: poisson,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: ElevatedButton(
                          onPressed: () {
                            //
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            child: const Text("Modifier"),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Card(
            elevation: 0,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //${journal['']}
                  ListTile(
                    leading: SvgPicture.asset(
                      "assets/SolarBoxLinear.svg",
                      height: 30,
                      width: 30,
                      color: Colors.indigo,
                    ),
                    title: const Text("Taille du poisson"),
                    subtitle: Text(
                      "${journal['commandes'][i]['taille']}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            elevation: 0,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //${journal['']}
                  ListTile(
                    leading: SvgPicture.asset(
                      "assets/SolarBoxLinear.svg",
                      height: 30,
                      width: 30,
                      color: Colors.indigo,
                    ),
                    title: const Text("Type de poisson"),
                    subtitle: Text(
                      "${journal['commandes'][i]['species']}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            elevation: 0,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //${journal['']}
                  ListTile(
                    leading: SvgPicture.asset(
                      "assets/SolarBoxLinear.svg",
                      height: 30,
                      width: 30,
                      color: Colors.indigo,
                    ),
                    title: const Text("Total de Box"),
                    subtitle: Text(
                      "${journal['commandes'][i]['totalBox']}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            elevation: 0,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //${journal['']}
                  ListTile(
                    leading: SvgPicture.asset(
                      "assets/SolarBoxLinear.svg",
                      height: 30,
                      width: 30,
                      color: Colors.indigo,
                    ),
                    title: const Text("Status"),
                    subtitle: Text(
                      "${journal['commandes'][i]['status']}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: 5,
                    ),
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: Obx(
                        () => DropdownButton(
                          isExpanded: true,
                          onChanged: (e) {
                            //
                            statuInt.value = e as int;
                            //
                          },
                          value: statuInt.value,
                          items: const [
                            DropdownMenuItem(value: 0, child: Text("Aucun")),
                            DropdownMenuItem(value: 1, child: Text("Complète")),
                            DropdownMenuItem(
                                value: 2, child: Text("Incomplète")),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              //status
              journal['status'] = statuInt.value;
              //
              journal['box2'] = box.text;
              //
              journal['pack2'] = pack.text;
              //
              journal['qtyFish2'] = quantite.text;
              //
              journal['totalFish2'] = poisson.text;
              //____

              //____
            },
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(
                const Size(
                  double.maxFinite,
                  45,
                ),
              ),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )),
              backgroundColor: MaterialStateProperty.all(Colors.blue.shade700),
            ),
            child: Container(
              alignment: Alignment.center,
              width: double.maxFinite,
              child: const Text(
                "Enregistrer",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
  //
}
