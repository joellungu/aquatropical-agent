import 'package:aquatropical_agent/pages/expeditions/expeditions_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Expedition extends GetView<ExpeditionController> {
  List produits = [
    {"": ""}
  ];
  //
  Expedition() {
    //
    controller.load();
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
              controller.obx(
                (state) {
                  //
                  List produits = state!;
                  //
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        //String e = liste.toList()[index];
                        //var r = produits[index];
                        Map produit = produits[index];
                        return InkWell(
                          splashColor: Colors.blue.shade100.withOpacity(0.5),
                          onTap: () {
                            //
                            // Get.to(
                            //   Details(
                            //     {"profil": "assets/maq${index + 4}-removebg-preview.png"},
                            //   ),
                            // );
                          },
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            height: Get.size.height / 4.5,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    elevation: 1,
                                    child: SizedBox(
                                      height: Get.size.height / 6.5,
                                      width: double.maxFinite,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Container(),
                                          ),
                                          Expanded(
                                            flex: 8,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Expanded(
                                                  flex: 3,
                                                  child: Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: const Text(
                                                      "Colis thailande",
                                                      style: TextStyle(
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    //color: Colors.amber,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          SvgPicture.asset(
                                                            "assets/SolarCalendarLinear.svg",
                                                            height: 30,
                                                            width: 30,
                                                            color:
                                                                Colors.indigo,
                                                          ),
                                                          Text(
                                                            " 24-01-2024",
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                              color: Colors.grey
                                                                  .shade700,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                      //color: Colors.cyan,
                                                      ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          SvgPicture.asset(
                                                            "assets/MynauiClockThree.svg",
                                                            height: 30,
                                                            width: 30,
                                                            color:
                                                                Colors.indigo,
                                                          ),
                                                          Text(
                                                            " 12:00",
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                              color: Colors.grey
                                                                  .shade700,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                      //color: Colors.cyan,
                                                      ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          SvgPicture.asset(
                                                            "assets/MynauiAeroplane.svg",
                                                            height: 30,
                                                            width: 30,
                                                            color:
                                                                Colors.indigo,
                                                          ),
                                                          Text(
                                                            " 456 67 8798",
                                                            style: TextStyle(
                                                              color: Colors.teal
                                                                  .shade700,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                      //color: Colors.teal,
                                                      ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        SvgPicture.asset(
                                                          "assets/SolarBoxLinear.svg",
                                                          height: 30,
                                                          width: 30,
                                                          color: Colors.indigo,
                                                        ),
                                                        const Text(
                                                          " Poids : ",
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                        Text(
                                                          " 100 Kg",
                                                          style: TextStyle(
                                                            color: Colors
                                                                .blue.shade900,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    //color: Colors.teal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 15, left: 5),
                                  padding: const EdgeInsets.all(3),
                                  height: Get.size.height / 4,
                                  width: Get.size.width / 4.5,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.blue.shade100.withOpacity(0.1),
                                        Colors.blue.shade100.withOpacity(0.1),
                                        Colors.blue.shade100.withOpacity(0.3),
                                        Colors.blue.shade100.withOpacity(0.4),
                                        Colors.blue.shade100.withOpacity(0.5),
                                        Colors.blue.shade100,
                                        Colors.blue.shade200,
                                        Colors.blue.shade300,
                                        Colors.blue.shade700,
                                      ],
                                      //tileMode: TileMode.decal,
                                      //stops: [0.1, 0.2, 0.3],
                                    ),
                                  ),
                                  child: Hero(
                                    tag: "assets/carton.png",
                                    child: Image.asset(
                                      "assets/carton.png",
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      childCount: produits.length,
                    ),
                  );
                },
                onLoading: const SliverToBoxAdapter(
                  child: Center(
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
                onEmpty: SliverToBoxAdapter(
                  child: Column(),
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
