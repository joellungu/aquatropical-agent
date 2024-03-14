import 'dart:convert';
import 'dart:io';

import 'package:aquatropical_agent/pages/expeditions/details_commande.dart';
import 'package:aquatropical_agent/pages/expeditions/expeditions_controller.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';

import 'loader.dart';

class VueTable extends StatefulWidget {
  //
  List<dynamic> rowsAsListOfValues;
  //
  Map journal;
  //
  String date;
  //
  VueTable(this.journal, this.rowsAsListOfValues, this.date);

  @override
  State<StatefulWidget> createState() {
    //
    return _VueTable();
  }
}

/// Example without a datasource
class _VueTable extends State<VueTable> {
  //
  ExpeditionController expeditionController = Get.find();
  //

  load(String fichier) async {
    String data = await getFileData(fichier);
    //
    print("data: $data");
    List<String> l = data.split("\n");
    //
    l.forEach((e) {
      List es = e.split(";");
      widget.rowsAsListOfValues.add(es);
      //
    });
    //
    //rowsAsListOfValues.value = const CsvToListConverter().convert(data);
    //
    print("dataa: ${l.length}");
    print("data: ${widget.rowsAsListOfValues.length}");
    //
    final input = File(fichier).openRead();
    // final fields = await input
    //     .transform(utf8.decoder)
    //     .transform(CsvToListConverter())
    //     .toList();
    // //
    // print("data: $fields");
  }

  //
  Future<String> getFileData(String path) async {
    return await rootBundle.loadString(path);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: DataTable2(
        columnSpacing: 12,
        horizontalMargin: 12,
        minWidth: 600,
        columns: const [
          DataColumn2(
            label: Text(
              'BOX',
              style: TextStyle(fontSize: 10),
            ),
            size: ColumnSize.S,
          ),
          DataColumn2(
            label: Text(
              'PACK',
              style: TextStyle(fontSize: 10),
            ),
            size: ColumnSize.S,
          ),
          DataColumn2(
            label: Text(
              'QTY FISH',
              style: TextStyle(fontSize: 10),
            ),
            size: ColumnSize.S,
          ),
          DataColumn2(
            label: Text(
              'TOTAL FISH',
              style: TextStyle(fontSize: 10),
            ),
            size: ColumnSize.S,
            //numeric: true,
          ),
          DataColumn2(
            label: Text(
              'SIZE/Cm',
              style: TextStyle(fontSize: 10),
            ),
            size: ColumnSize.S,
          ),
          DataColumn(
            label: Text(
              'SPECIES',
              style: TextStyle(fontSize: 10),
            ),
            //numeric: true,
          ),
          DataColumn2(
            label: Text(
              'TOTAL BOX',
              style: TextStyle(fontSize: 10),
            ),
            size: ColumnSize.S,
          ),
          // DataColumn2(
          //   label: Text(
          //     'Status',
          //     style: TextStyle(fontSize: 10),
          //   ),
          //   size: ColumnSize.S,
          // ),
        ],
        rows: List<DataRow>.generate(
          widget.rowsAsListOfValues.length,
          (index) {
            var l = widget.rowsAsListOfValues[index];
            print("liste: $l");
            //
            return DataRow(
              color: l['status'] == 0
                  ? MaterialStateProperty.all(
                      Colors.grey.shade100.withOpacity(0.5))
                  : MaterialStateProperty.all(Colors.grey.shade300),
              onLongPress: () {
                //
                if (widget.journal['status'] == 0) {
                  setState(() {
                    //
                    Map x = l;
                    x['status'] = 1;
                    //
                    widget.rowsAsListOfValues.insert(index + 1, x);
                    //
                    print("taille: ${widget.rowsAsListOfValues.length}");
                  });
                }
              },
              cells: [
                DataCell(
                  Text(
                    '${l['box']} / ${l['box2'] ?? ''}',
                    style: const TextStyle(fontSize: 10),
                  ),
                  onTap: () {
                    //
                    if (widget.journal['status'] == 0) modifier("box", index);
                    //Get.to(DetailsCommande(journal, index));
                  },
                  //showEditIcon: true,
                ),
                DataCell(
                  Text(
                    '${l['pack']} / ${l['pack2'] ?? ''}',
                    style: const TextStyle(fontSize: 10),
                  ),
                  onTap: () {
                    //
                    if (widget.journal['status'] == 0) modifier("pack", index);
                    //Get.to(DetailsCommande(journal, index));
                  },
                ),
                DataCell(
                  Text(
                    '${l['qtyFish']} / ${l['qtyFish2'] ?? ''}',
                    style: const TextStyle(fontSize: 10),
                  ),
                  onTap: () {
                    //
                    if (widget.journal['status'] == 0)
                      modifier("qtyFish", index);
                    //Get.to(DetailsCommande(journal, index));
                  },
                ),
                DataCell(
                  Text(
                    '${l['totalFish']} / ${l['totalFish2'] ?? ''}',
                    style: const TextStyle(fontSize: 10),
                  ),
                  onTap: () {
                    //
                    if (widget.journal['status'] == 0)
                      modifier("totalFish", index);
                    //Get.to(DetailsCommande(journal, index));
                  },
                ),
                DataCell(
                  Text(
                    '${l['taille']}',
                    style: const TextStyle(fontSize: 10),
                  ),
                  // onTap: () {
                  //   //
                  //   Get.to(DetailsCommande(journal, index));
                  // },
                ),
                DataCell(
                  Text(
                    '${l['species']}',
                    style: const TextStyle(fontSize: 10),
                  ),
                  // onTap: () {
                  //   //
                  //   Get.to(DetailsCommande(journal, index));
                  // },
                ),
                DataCell(
                  Text(
                    "${l['totalBox']}",
                    style: const TextStyle(fontSize: 10),
                  ),
                  // onTap: () {
                  //   //
                  //   Get.to(DetailsCommande(journal, index));
                  // },
                ),
                // DataCell(
                //   l['status'] == 0
                //       ? const Icon(
                //           Icons.check_circle,
                //           color: Colors.green,
                //         )
                //       : l['status'] == 1
                //           ? const Icon(Icons.warning)
                //           : const Icon(Icons.attachment),
                //   onTap: () {
                //     //
                //   },
                // )
              ],
            );
          },
        ),
      ),
    );
  }

  //
  modifier(String type, int i) {
    //
    TextEditingController box = TextEditingController();
    //
    Get.dialog(
      Center(
        child: Card(
          elevation: 1,
          child: Container(
            padding: const EdgeInsets.all(10),
            height: 250,
            width: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "Modifier le nombre de Pack",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextField(
                  controller: box,
                  textAlign: TextAlign.center,
                  focusNode: FocusNode(),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    //
                    Get.back();
                    //
                    //Loader.attente();
                    print("L'index vaut: $i");

                    setState(() {
                      //
                      //       if(){
                      //         journal['status'] = box.value;
                      // //
                      //       }
                      if (type == "box") {
                        widget.rowsAsListOfValues[i]['box2'] = box.text;
                        //
                      }
                      if (type == "pack") {
                        widget.rowsAsListOfValues[i]['pack2'] = box.text;
                        //
                      }
                      if (type == "qtyFish") {
                        widget.rowsAsListOfValues[i]['qtyFish2'] = box.text;
                      }
                      if (type == "totalFish") {
                        //
                        widget.rowsAsListOfValues[i]['totalFish2'] = box.text;
                      }
                      //
                      widget.journal['commandes'] = widget.rowsAsListOfValues;
                      //
                      //Get.back();
                    });
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
                      "Modiffier",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
