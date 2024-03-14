import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:data_table_2/data_table_2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:excel/excel.dart' as ex;
import 'package:open_filex/open_filex.dart';
import 'dart:io' as io;

import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';

class Exceller extends StatelessWidget {
  //
  List rls = [];
  List resultats = [];
  //
  Exceller(this.rls) {
    for (int i = 0; i < rls.length; i++) {
      Map saisie = rls[i];
      //
      resultats.add(saisie);

      //
    }
    // resultats.forEach((saisie) {
    //   //

    // });
  }
  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              //
              // automatically creates 1 empty sheet: Sheet1
              ex.Excel excel = ex.Excel.createExcel();
              //
              //excel.sheets.clear();
              //
              // excel.appendRow('SheetName', [
              //   "Nom",
              //   "Post-Nom",
              //   "Prenom",
              //   "Date",
              //   "Age",
              // ]);
              // //
              ex.Sheet sheetObject = excel['RAPPORT MENSUEL'];

              //

              ex.CellStyle cellStyle = ex.CellStyle(
                  backgroundColorHex: '#1AFF1A',
                  fontFamily: ex.getFontFamily(ex.FontFamily.Calibri));

              cellStyle.underline = ex.Underline.Single; // or Underline.Double

              var date = sheetObject.cell(ex.CellIndex.indexByString('A1'));
              date.value = 'DATE'.toUpperCase();
              // dynamic values support provided;
              date.cellStyle = cellStyle;
              //
              // var cell1 = sheetObject.cell(ex.CellIndex.indexByString('A2'));
              // cell1.value = 'DATE'.toUpperCase();
              // // dynamic values support provided;
              // cell1.cellStyle = cellStyle;
              //________________________________________________________________
              // var b1 = sheetObject.cell(ex.CellIndex.indexByString('B1'));
              // //
              // b1.value = 'ENTREE'.toUpperCase();
              // // dynamic values support provided;
              // b1.cellStyle = cellStyle;
              // var c1 = sheetObject.cell(ex.CellIndex.indexByString('C1'));
              // //
              // c1.value = 'ENTREE'.toUpperCase();
              // // dynamic values support provided;
              // c1.cellStyle = cellStyle;
              //________________________________________________________________
              //
              var cell11 = sheetObject.cell(ex.CellIndex.indexByString('B1'));
              //
              cell11.value = 'QUANTITE'.toUpperCase();
              // dynamic values support provided;
              cell11.cellStyle = cellStyle;
              //
              var cell2 = sheetObject.cell(ex.CellIndex.indexByString("C1"));
              cell2.value = 'ENTREE USD'.toUpperCase();

              // dynamic values support provided;
              cell2.cellStyle = cellStyle;
              //
              var cell3 = sheetObject.cell(ex.CellIndex.indexByString('D1'));
              cell3.value = 'ENTREE CDF'.toUpperCase();

              // dynamic values support provided;
              cell3.cellStyle = cellStyle;
              //
              var cell4 = sheetObject.cell(ex.CellIndex.indexByString('E1'));
              cell4.value = 'DEPENSE USD'.toUpperCase();
              // dynamic values support provided;
              cell4.cellStyle = cellStyle;
              //
              var cell5 = sheetObject.cell(ex.CellIndex.indexByString("F1"));
              cell5.value = "DEPENSE CDF".toUpperCase();
              //cell5.value = 8; // dynamic values support provided;
              cell5.cellStyle = cellStyle;
              //
              var cell6 = sheetObject.cell(ex.CellIndex.indexByString('G1'));
              cell6.value = 'TAUX'.toUpperCase();
              // dynamic values support provided;
              cell6.cellStyle = cellStyle;
              //
              var cell7 = sheetObject.cell(ex.CellIndex.indexByString('H1'));
              cell7.value = 'SOLDE CDF'.toUpperCase();

              // dynamic values support provided;
              cell7.cellStyle = cellStyle;
              //
              var cell8 = sheetObject.cell(ex.CellIndex.indexByString('I1'));
              cell8.value = 'SOLDE USD'.toUpperCase();

              // dynamic values support provided;
              cell8.cellStyle = cellStyle;
              //QUANTITE
              var cell9 = sheetObject.cell(ex.CellIndex.indexByString('J1'));
              cell9.value = 'TOTAL'.toUpperCase();
              // dynamic values support provided;
              cell9.cellStyle = cellStyle;
              //
              var cell10 = sheetObject.cell(ex.CellIndex.indexByString('K1'));
              cell10.value = 'REMARQUE'.toUpperCase();
              // dynamic values support provided;
              cell10.cellStyle = cellStyle;
              // dynamic values support provided;
              //________________________________________________________________
              //
              //
              // sheetObject.merge(ex.CellIndex.indexByString('A1'),
              //     ex.CellIndex.indexByString('A2'),
              //     customValue: "DATE");
              // //
              // sheetObject.merge(ex.CellIndex.indexByString('B1'),
              //     ex.CellIndex.indexByString('B2'),
              //     customValue: "QUATITE");
              // //
              // sheetObject.merge(ex.CellIndex.indexByString('C1'),
              //     ex.CellIndex.indexByString('D1'),
              //     customValue: "ENTREE");
              // //
              // sheetObject.merge(ex.CellIndex.indexByString('E1'),
              //     ex.CellIndex.indexByString('F1'),
              //     customValue: "DEPENSE");
              // //
              // sheetObject.merge(ex.CellIndex.indexByString('G1'),
              //     ex.CellIndex.indexByString('G2'),
              //     customValue: "TAUX");

              // //
              // sheetObject.merge(ex.CellIndex.indexByString('H1'),
              //     ex.CellIndex.indexByString('I1'),
              //     customValue: "SOLDE");
              // //
              // sheetObject.merge(ex.CellIndex.indexByString('K1'),
              //     ex.CellIndex.indexByString('K2'),
              //     customValue: "REMARQUE");
              // //
              sheetObject.setDefaultColumnWidth(15);
              //
              //sheetObject.printInfo(printFunction: print, info: "infos");
              //
              print("fit d: ${date.cellIndex}");
              print("fit dc: ${date.columnIndex}");
              print("fit dr: ${date.rowIndex}");
              //
              print("fit 1: ${cell11.cellIndex}");
              print("fit 1c: ${cell11.columnIndex}");
              print("fit 1r: ${cell11.rowIndex}");
              //
              print("fit 2: ${cell2.cellIndex}");
              print("fit 2c: ${cell2.columnIndex}");
              print("fit 2r: ${cell2.rowIndex}");
              //
              print("fit 3: ${cell3.cellIndex}");
              print("fit 3c: ${cell3.columnIndex}");
              print("fit 3r: ${cell3.rowIndex}");
              //
              print("fit cell10: ${cell10.cellIndex}");
              print("fit cell10c: ${cell10.columnIndex}");
              print("fit cell10r: ${cell10.reactive}");
              //
              print("fit: ${sheetObject.maxRows}");
              //____________________________________________________________
              //____________________________________________________________
              for (Map saisie in resultats) {
                //
                String entreeUSD = saisie['categorie'] == "Entrée Caisse" &&
                        saisie['devise'] == "USD"
                    ? "${saisie['montant']}"
                    : "";
                String entreeCDF = saisie['categorie'] == "Entrée Caisse" &&
                        saisie['devise'] == "CDF"
                    ? "${saisie['montant']}"
                    : "";
                //
                String depenseUSD = saisie['categorie'] != "Entrée Caisse" &&
                        saisie['devise'] == "USD"
                    ? "${saisie['montant']}"
                    : "";
                String depenseCDF = saisie['categorie'] != "Entrée Caisse" &&
                        saisie['devise'] == "CDF"
                    ? "${saisie['montant']}"
                    : "";
                //

                //
                //
                sheetObject.appendRow([
                  "${saisie['date'] ?? ''}",
                  "${saisie['quantite']}",
                  entreeUSD,
                  entreeCDF,
                  depenseUSD,
                  depenseCDF,
                  "${saisie['taux'] ?? ''}",
                  "",
                  "",
                  "",
                  saisie['categorie'] == "Facture Poisson"
                      ? "${saisie['remarque']}".split(",")[1]
                      : "${saisie['remarque']}",
                ]);
                //

                //
              }

              //
              //excel['RAPPORT MENSUEL'] = sheetObject;

// printing cell-type
              //print('CellType: ' + cell1.cellType.toString());

              ///
              /// Inserting and removing column and rows

// insert column at index = 8
              //sheetObject.insertColumn(8);

// remove column at index = 18
              //sheetObject.removeColumn(18);

// insert row at index = 82
              //sheetObject.insertRow(82);

// remove row at index = 80
              //sheetObject.removeRow(80);
              //excel.appendRow("sheet", []);
              //----------------------------------------------------------------
              // String? outputFile = await FilePicker.platform.saveFile(
              //     dialogTitle: 'Save Your File to desired location',
              //     fileName: "Rapport Excel.xlsx");
              //print("fit: ${sheetObject.toString()}");

              try {
                //
                final Directory? downloadsDir = await getDownloadsDirectory();
                //
                //final file = io.File("$outputFile");
                //----------------------------------------------------------------
                // when you are in flutter web then save() downloads the excel file.
                //
                String nom = "Rapport 4 Excel.xlsx";
                //
                // Call function save() to download the file
                List<int>? fileBytes =
                    excel.save(fileName: '${downloadsDir!.path}/$nom');
                //print("data: $outputFile");
                //print("data: ${fileBytes}");
                // io.File("Rapport Excel.xlsx")
                //   ..createSync(recursive: true)
                //   ..writeAsBytesSync(fileBytes!);
                //

                // String r = await FileSaver.instance.saveFile(
                //     bytes: Uint8List.fromList(fileBytes!),
                //     name: 'Rapport Excel.xlsx');
                //     //
                //
                Directory? dir = Platform.isAndroid
                    ? await getExternalStorageDirectory()
                    : await getApplicationDocumentsDirectory();
                File testFile = File("${dir!.path}/aquatropical/$nom");
                testFile.writeAsBytesSync(Uint8List.fromList(fileBytes!));
                //ShareExtend.share(testFile.path, "file");
                //
                OpenResult openResult =
                    await OpenFilex.open("${dir.path}/aquatropical/$nom");
                //
                print("reponse: ${openResult.message}");
                print("reponse: ${dir.path}");
                //
                //await file.writeAsBytes(await pdf.save());
                //io.File returnedFile = io.File('$outputFile');
                //await returnedFile.writeAsString("Salut bro");
              } catch (e) {
                Get.snackbar("Erreur", "Un problème d'enregistrement ($e)");
              }
              //----------------------------------------------------------------
            },
            icon: SvgPicture.asset(
              "assets/MynauiLocation.svg",
              colorFilter: const ColorFilter.mode(Colors.blue, BlendMode.srcIn),

              //semanticsLabel: e["titre"],
              height: 30,
              width: 30,
            ),
          ),
        ],
      ),
      body: DataTable2(
        columnSpacing: 12,
        horizontalMargin: 12,
        minWidth: 1000,
        columns: const [
          DataColumn2(
            label: Text(
              'DATE',
              style: TextStyle(fontSize: 10),
            ),
            size: ColumnSize.M,
          ),
          DataColumn2(
            label: Text(
              'QUANTITE',
              style: TextStyle(fontSize: 10),
            ),
            size: ColumnSize.M,
          ),
          DataColumn2(
            label: Text(
              'ENTREE USD',
              style: TextStyle(fontSize: 10),
            ),
            size: ColumnSize.M,
          ),
          DataColumn2(
            label: Text(
              'ENTREE CDF',
              style: TextStyle(fontSize: 10),
            ),
            size: ColumnSize.M,
          ),
          DataColumn2(
            label: Text(
              'DEPENSE USD',
              style: TextStyle(fontSize: 10),
            ),
            size: ColumnSize.M,
            //numeric: true,
          ),
          DataColumn2(
            label: Text(
              'DEPENSE CDF',
              style: TextStyle(fontSize: 10),
            ),
            size: ColumnSize.M,
          ),
          DataColumn2(
            label: Text(
              'TAUX',
              style: TextStyle(fontSize: 10),
            ),
            size: ColumnSize.S,
            //numeric: true,
          ),
          DataColumn2(
            label: Text(
              'SOLDE CDF',
              style: TextStyle(fontSize: 10),
            ),
            size: ColumnSize.M,
          ),
          DataColumn2(
            label: Text(
              'SOLDE USD',
              style: TextStyle(fontSize: 10),
            ),
            size: ColumnSize.M,
          ),
          DataColumn2(
            label: Text(
              'TOTAL',
              style: TextStyle(fontSize: 10),
            ),
            size: ColumnSize.M,
          ),
          DataColumn(
            label: Text(
              'REMARQUE',
              style: TextStyle(fontSize: 10),
            ),
            //size: ColumnSize.L,
          ),
        ],
        rows: List<DataRow>.generate(
          resultats.length,
          (index) {
            Map saisie = resultats[index];
            String entreeUSD = saisie['categorie'] == "Entrée Caisse" &&
                    saisie['devise'] == "USD"
                ? "${saisie['montant']}"
                : "";
            String entreeCDF = saisie['categorie'] == "Entrée Caisse" &&
                    saisie['devise'] == "CDF"
                ? "${saisie['montant']}"
                : "";
            //
            String depenseUSD = saisie['categorie'] != "Entrée Caisse" &&
                    saisie['devise'] == "USD"
                ? "${saisie['montant']}"
                : "";
            String depenseCDF = saisie['categorie'] != "Entrée Caisse" &&
                    saisie['devise'] == "CDF"
                ? "${saisie['montant']}"
                : "";

            //print("saisie: $saisie");
            //
            return DataRow(
              color: MaterialStateProperty.all(Colors.grey.shade200),
              onLongPress: () {
                //
              },
              cells: [
                DataCell(
                  Text(
                    '${saisie['date'] ?? ''}',
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  //showEditIcon: true,
                ),
                DataCell(
                  Text(
                    '${saisie['quantite'] ?? ''}',
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  //showEditIcon: true,
                ),
                DataCell(
                  Text(
                    entreeUSD,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataCell(
                  Text(
                    entreeCDF,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataCell(
                  Text(
                    depenseUSD,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataCell(
                  Text(
                    depenseCDF,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataCell(
                  Text(
                    '${saisie['taux']}',
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const DataCell(
                  Text(
                    "",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const DataCell(
                  Text(
                    "",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const DataCell(
                  Text(
                    "",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataCell(
                  saisie['categorie'] == "Facture Poisson"
                      ? Text(
                          "${saisie['remarque']}".split(",")[1],
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : Text(
                          "${saisie['remarque']}",
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
  //
}
