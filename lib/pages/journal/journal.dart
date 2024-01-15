import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'journal_controller.dart';
import 'nouveau_journal.dart';

class Journal extends GetView<JournalController> {
  //
  RxList rapports = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20
  ].obs;
  //
  Journal() {
    //
    DateTime date = DateTime.now();
    //
    String d = "${date.day}-${date.month}-${date.year}";
    //
    controller.getForMonth(d);
    //
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
                  background: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: CalendarDatePicker(
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2024),
                          lastDate: DateTime(2030),
                          onDateChanged: (d) {
                            print("date: $d");
                          },
                        ),
                      ),
                    ],
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
                                child: Switch(
                                  onChanged: (e) {},
                                  value: true,
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
              Obx(
                () => SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      //String e = liste.toList()[index];
                      var r = rapports[index];

                      return ListTile(
                        onTap: () {
                          //
                        },
                        leading: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            // image: DecorationImage(
                            //     image: ExactAssetImage(
                            //         "assets/${rapports[index]}"),
                            //     fit: BoxFit.cover),
                            //border: Border.all(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        title: const Text(
                          "Hotel les délices du Ciel",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: RichText(
                          text: TextSpan(
                            text: "",
                            children: [
                              WidgetSpan(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow.shade700,
                                      size: 15,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow.shade700,
                                      size: 15,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow.shade700,
                                      size: 15,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow.shade700,
                                      size: 15,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow.shade700,
                                      size: 15,
                                    ),
                                  ],
                                ),
                              ),
                              const TextSpan(text: "\n"),
                              TextSpan(
                                text: "Matadit Q/Tsimba, Av: bulimo, N°20/22B",
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    childCount: rapports.length,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //
          Get.to(NouveauJournal());
          //
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
