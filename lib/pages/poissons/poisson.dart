import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'nouveau_poisson.dart';
import 'poisson_controller.dart';

class Poisson extends GetView<PoissonController> {
  Poisson() {
    //
    controller.getAll();
    //
  }
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: controller.obx(
        (state) {
          //
          RxList poissons = RxList(state!);
          //
          RxString mot = "".obs;
          //
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: TextField(
                  onChanged: (t) {
                    //
                    mot.value = t;
                    //
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: "Nom du poisson",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Obx(
                  () => ListView(
                    padding: EdgeInsets.all(20),
                    children: List.generate(
                      poissons.length,
                      (index) {
                        Map poisson = poissons[index];
                        //
                        if ("${poisson['nom']}"
                            .toLowerCase()
                            .contains(mot.value.toLowerCase())) {
                          //
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
                            subtitle: Text.rich(
                              TextSpan(
                                text: "${poisson['prixUSD']} ",
                                children: [
                                  const TextSpan(
                                    text: "USD\n",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.indigo,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "${poisson['taille']}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.green.shade900,
                                    ),
                                    //children: [TextSpan(text: "")],
                                  ),
                                ],
                              ),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                            trailing: Text(
                              "${poisson['quantite']}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          );
                          //
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        onEmpty: Container(),
        onLoading: const Center(
          child: SizedBox(
            height: 40,
            width: 40,
            child: CircularProgressIndicator(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //
          Get.to(NouvelPoisson());
        },
        child: SvgPicture.asset(
          "assets/GalaAdd.svg",
          height: 30,
          width: 30,
        ),
      ),
    );
  }
}
