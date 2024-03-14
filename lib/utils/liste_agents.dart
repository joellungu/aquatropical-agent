import 'dart:convert';
import 'dart:ffi';

import 'package:aquatropical_agent/pages/journal/journal_controller.dart';
import 'package:aquatropical_agent/pages/poissons/poisson_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'agent_controller.dart';

class ListAgent extends GetView<AgentController> {
  //
  JournalController journalController = Get.find();
  //
  ListAgent() {
    //
    controller.getAll();
    //
  }

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      body: controller.obx(
        (state) {
          //
          RxList agents = RxList(state!);
          //
          RxString mot = "".obs;
          //
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 20, left: 25, right: 25),
                child: TextField(
                  onChanged: (t) {
                    //
                    mot.value = t;
                    //
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: "Nom de l'agent",
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
                      agents.length,
                      (index) {
                        Map agent = agents[index];
                        //
                        if ("${agent['nom']}"
                            .toLowerCase()
                            .contains(mot.value.toLowerCase())) {
                          //
                          return ListTile(
                            onTap: () {
                              //
                              //
                              Get.back();
                              //
                              journalController.agent.value = agent;
                            },
                            leading: SvgPicture.asset(
                              "assets/FluentEmojiHighContrastTropicalFish.svg",
                              height: 30,
                              width: 30,
                            ),
                            title: Text(
                              "${agent['nom']} ${agent['postnom']} ${agent['prenom']}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text.rich(
                              TextSpan(
                                text: "${agent['telephone']} \n",
                                children: [
                                  TextSpan(
                                    text: "${agent['role']}",
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
    );
  }
}
