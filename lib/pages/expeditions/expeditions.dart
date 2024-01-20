import 'package:aquatropical_agent/pages/expeditions/expeditions_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'details_expeditions.dart';

class Expedition extends GetView<ExpeditionController> {
  List produits = [
    {"": ""}
  ];
  //
  RxBool mois = true.obs;
  //
  Expedition() {
    //
    //
    DateTime date = DateTime.now();
    //
    String d = "${date.day}-${date.month}-${date.year}";
    //
    if (mois.value) {
      controller.getForMonth(d);
    } else {
      controller.getForDay(d);
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                // title: Text(
                //   "Salut",
                //   style: TextStyle(color: Colors.black),
                // ),
                //backgroundColor: Colors.grey,
                onStretchTrigger: () {
                  print("Le truc strck");
                  return Future.value();
                },
                pinned: true,
                snap: false,
                floating: false,
                expandedHeight: Get.size.height / 2.7,
                flexibleSpace: FlexibleSpaceBar(
                  expandedTitleScale: 2,
                  // title: Container(
                  //   height: 35,
                  //   alignment: Alignment.center,
                  //   // padding: const EdgeInsets.symmetric(
                  //   //   horizontal: 5,
                  //   // ),
                  //   child: TextField(
                  //     decoration: InputDecoration(
                  //       border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(15)),
                  //       prefixIcon: Container(
                  //         padding: EdgeInsets.all(5),
                  //         height: 20,
                  //         width: 20,
                  //         child: SvgPicture.asset(
                  //           "assets/GalaSearch.svg",
                  //           height: 20,
                  //           width: 20,
                  //           color: Colors.indigo,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  background: Obx(
                    () => !mois.value
                        ? Container(
                            padding: const EdgeInsets.all(10),
                            child: CalendarDatePicker(
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2024),
                              lastDate: DateTime(2030),
                              onDateChanged: (dd) async {
                                print("date: $dd");
                                //
                                String d = "${dd.day}-${dd.month}-${dd.year}";
                                //
                                controller.getForDay(d);
                              },
                            ),
                          )
                        : Center(
                            child: Text("Journal du mois"),
                          ),
                  ),
                  centerTitle: false,
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 90,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50,
                        width: Get.size.width / 1.1,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                              flex: 4,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    CupertinoIcons.calendar,
                                    size: 30,
                                    color: Colors.indigo,
                                  ),
                                  Text(
                                    " Tout le mois ",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Obx(
                                  () => Switch(
                                    onChanged: (e) async {
                                      //
                                      mois.value = e;
                                      //
                                      DateTime date = DateTime.now();
                                      //
                                      if (mois.value) {
                                        //
                                        String d =
                                            "${date.day}-${date.month}-${date.year}";
                                        //
                                        controller.getForMonth(d);
                                      } else {
                                        String d =
                                            "${date.day}-${date.month}-${date.year}";
                                        //
                                        controller.getForDay(d);
                                      }
                                      print("mois.value: ${mois.value}");
                                      //
                                    },
                                    value: mois.value,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
              controller.obx(
                (state) {
                  List journals = state!;
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        //String e = liste.toList()[index];
                        var j = journals[index];
                        print("journal: $j");
                        return ListTile(
                          onTap: () {
                            //
                            Get.to(DetailsExpedition(j));
                            //
                          },
                          leading: Container(
                            height: 30,
                            width: 30,
                            child: SvgPicture.asset(
                              "assets/MynauiSend.svg",
                              height: 30,
                              width: 30,
                            ),
                            decoration: BoxDecoration(
                              // image: DecorationImage(
                              //     image: ExactAssetImage(
                              //         "assets/${rapports[index]}"),
                              //     fit: BoxFit.cover),
                              //border: Border.all(color: Colors.black, width: 2),
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          title: Text(
                            "${j['titre']}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: RichText(
                            text: TextSpan(
                              text: "${j['date']}   ${j['heure']}\n",
                              style: TextStyle(
                                color: Colors.green.shade700,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                    //
                                    text: j['status'] == 0
                                        ? "En attente"
                                        : j['status'] == 1
                                            ? "En transite"
                                            : "Expedié",
                                    style: TextStyle(
                                      color: j['status'] == 0
                                          ? Colors.blue.shade700
                                          : j['status'] == 1
                                              ? Colors.amber.shade700
                                              : Colors.green.shade700,
                                      fontWeight: FontWeight.bold,
                                    )),

                                // WidgetSpan(
                                //   child: FutureBuilder(
                                //     future:
                                //         controller.getAgent('${j['idAgent']}'),
                                //     builder: (c, t) {
                                //       if (t.hasData) {
                                //         Map agent = t.data as Map;
                                //         return Text(
                                //             "${agent['nom'] ?? ''} ${agent['postnom'] ?? ''} ${agent['prenom'] ?? ''}");
                                //       } else if (t.hasError) {
                                //         return Container();
                                //       }
                                //       return Container();
                                //     },
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        );
                      },
                      childCount: journals.length,
                    ),
                  );
                },
                onEmpty: SliverToBoxAdapter(
                  child: Container(),
                ),
                onLoading: const SliverToBoxAdapter(
                  child: Center(
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 100,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
