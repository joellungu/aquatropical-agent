import 'package:aquatropical_agent/pages/expeditions/expeditions.dart';
import 'package:aquatropical_agent/pages/fournisseurs/fournisseurs.dart';
import 'package:aquatropical_agent/pages/materiels/materiels.dart';
import 'package:aquatropical_agent/pages/poissons/poisson.dart';
import 'package:aquatropical_agent/pages/profil/profile_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'journal/journal.dart';

class Accueil extends StatelessWidget {
  //
  RxInt currentIndex = 0.obs;
  //Produits()//Agents()//Expedition()
  Rx vue = Rx<Widget>(Journal());
  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        title: const Text("AquaTropical"),
        centerTitle: true,
      ),
      body: Obx(() => vue.value),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: currentIndex.value,
          onTap: (e) {
            //
            currentIndex.value = e;
            //
            if (e == 0) {
              vue.value = Journal();
            } else if (e == 1) {
              vue.value = Poisson();
            } else if (e == 2) {
              vue.value = Fournisseur();
            } else if (e == 3) {
              vue.value = Materiel();
            } else if (e == 4) {
              vue.value = Expedition();
            } else {
              vue.value = ProfileDetails();
            }
          },
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade400,
          ),
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey.shade400,
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/SolarChecklistMinimalisticLinear.svg",
                  height: 30,
                  width: 30,
                ),
                activeIcon: SvgPicture.asset(
                  "assets/SolarChecklistMinimalisticLinear.svg",
                  height: 30,
                  width: 30,
                  color: Colors.indigo,
                ),
                label: "Journal"),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/FluentEmojiHighContrastTropicalFish.svg",
                  height: 30,
                  width: 30,
                ),
                activeIcon: SvgPicture.asset(
                    "assets/FluentEmojiHighContrastTropicalFish.svg",
                    height: 30,
                    width: 30,
                    color: Colors.indigo),
                label: "Poissons"),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/SolarUsersGroupRoundedLinear.svg",
                  height: 30,
                  width: 30,
                ),
                activeIcon: SvgPicture.asset(
                    "assets/SolarUsersGroupRoundedLinear.svg",
                    height: 30,
                    width: 30,
                    color: Colors.indigo),
                label: "Fournisseurs"),
            BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                  "assets/SolarBoxLinear.svg",
                  height: 30,
                  width: 30,
                  color: Colors.indigo,
                ),
                icon: SvgPicture.asset(
                  "assets/SolarBoxLinear.svg",
                  height: 30,
                  width: 30,
                ),
                label: "Materiels"),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/MynauiSend.svg",
                  height: 30,
                  width: 30,
                ),
                activeIcon: SvgPicture.asset(
                  "assets/MynauiSend.svg",
                  height: 30,
                  width: 30,
                  color: Colors.indigo,
                ),
                label: "Expédition"),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/GalaPortrait1.svg",
                  height: 30,
                  width: 30,
                ),
                activeIcon: SvgPicture.asset(
                  "assets/GalaPortrait1.svg",
                  height: 30,
                  width: 30,
                  color: Colors.indigo,
                ),
                label: "Expédition"),
          ],
        ),
      ),
    );
  }
}
