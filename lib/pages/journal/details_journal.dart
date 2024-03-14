import 'dart:convert';
import 'dart:ui';

import 'package:aquatropical_agent/pages/journal/journal_controller.dart';
import 'package:aquatropical_agent/utils/frais_supplementaire.dart';
import 'package:aquatropical_agent/utils/liste_fournisseur.dart';
import 'package:aquatropical_agent/utils/liste_materiels.dart';
import 'package:aquatropical_agent/utils/liste_poissons.dart';
import 'package:aquatropical_agent/utils/loader.dart';
import 'package:aquatropical_agent/utils/recherche.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
//
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'impression_blue.dart';

//
class DetailsJournal extends StatelessWidget {
  //
  String idFacture;
  //
  List remarque = [];
  //
  Map ags = {};
  //
  DetailsJournal(this.idFacture) {
    //
    // print("journal: $journal");
    // //
    // roles = [journal['type']];
    // //
    // fournisseur = journal['fournisseur'] ?? {};
    // //
    // materiels = journal['materiels'] ?? [];
    // //
    // poissons = journal['poissons'] ?? [];
    // //
    // frais = journal['fraisSupllementaire'] ?? [];
    // //
    // remarque = jsonDecode(journal['remarque']);
  }
  //
  JournalController journalController = Get.find();
  //
  Map fournisseur = {};
  //
  List poissons = [];
  //
  List materiels = [];
  //
  Map frais = {};
  //
  Map agent = {};
  String date = "", heure = "";
  double taux = 0.0;
  String devise = "";
  //
  List roles = ["Facture", "Achat materiel", "Perte poissons"];
  RxInt role = 0.obs;
  //
  @override
  Widget build(BuildContext context) {
    //
    return FutureBuilder(
      future: journalController.getFacture(idFacture),
      builder: ((c, t) {
        if (t.hasData) {
          //
          Map journal = t.data as Map;
          //
          date = journal['date'];
          heure = journal['heure'];
          fournisseur = journal['fournisseur'];
          poissons = journal['poissons'];
          frais = journal['frais'];
          agent = journal['agent'];
          taux = journal['taux'];
          devise = journal['devise'];

          //
          return Scaffold(
            appBar: AppBar(
              title: const Text("Details"),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {
                    //
                    //Get.to(ImpressionBlue());
                  },
                  icon: const Icon(Icons.bluetooth_connected),
                ),
                IconButton(
                  onPressed: () async {
                    //
                    //Loader.attente();
                    // final pdf = pw.Document();
                    // pdf.addPage(
                    //   pw.MultiPage(
                    //     margin: const pw.EdgeInsets.all(3),
                    //     header: (c) {
                    //       //
                    //       return pw.Column(
                    //         children: [
                    //           pw.Row(
                    //             mainAxisAlignment:
                    //                 pw.MainAxisAlignment.spaceBetween,
                    //             children: [
                    //               pw.Expanded(
                    //                 flex: 3,
                    //                 child: pw.Text(
                    //                     "${journal['date']}   ${journal['heure']}"),
                    //               ),
                    //               pw.Expanded(
                    //                 flex: 3,
                    //                 child: pw.Center(
                    //                   child: pw.Text("${journal['type']}"),
                    //                 ),
                    //               ),
                    //               pw.Expanded(
                    //                 flex: 3,
                    //                 child: pw.Container(
                    //                   alignment: pw.Alignment.centerRight,
                    //                   child: pw.Text("N° ${journal['id']}"),
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //           pw.Container(
                    //             margin: pw.EdgeInsets.all(1),
                    //             height: 2,
                    //             width: double.maxFinite,
                    //             color: PdfColors.black,
                    //           ),
                    //           pw.Container(
                    //             margin: pw.EdgeInsets.all(1),
                    //             height: 2,
                    //             width: double.maxFinite,
                    //             color: PdfColors.black,
                    //           ),
                    //           pw.SizedBox(
                    //             height: 10,
                    //           ),
                    //           pw.Row(
                    //             mainAxisAlignment: pw.MainAxisAlignment.center,
                    //             children: [
                    //               pw.Text(
                    //                 "AquaTropical",
                    //                 style: pw.TextStyle(
                    //                     fontWeight: pw.FontWeight.bold),
                    //               )
                    //             ],
                    //           ),
                    //           //
                    //           pw.SizedBox(height: 10),
                    //           pw.Container(
                    //             height: 15,
                    //             child: pw.Text(
                    //               "Agent",
                    //               style: pw.TextStyle(
                    //                 color: PdfColors.white,
                    //               ),
                    //             ),
                    //             alignment: pw.Alignment.centerLeft,
                    //             color: PdfColors.black,
                    //             width: double.maxFinite,
                    //           ),
                    //           pw.Row(
                    //             mainAxisAlignment: pw.MainAxisAlignment.start,
                    //             children: [
                    //               pw.Text(
                    //                   "${ags['nom']} ${ags['postnom']} ${ags['prenom']}")
                    //             ],
                    //           ),
                    //           pw.Row(
                    //             mainAxisAlignment: pw.MainAxisAlignment.start,
                    //             children: [pw.Text("${ags['telephone']} ")],
                    //           ),
                    //           pw.Row(
                    //             mainAxisAlignment: pw.MainAxisAlignment.start,
                    //             children: [pw.Text("${ags['adresse']} ")],
                    //           ),
                    //           //
                    //           pw.SizedBox(height: 10),
                    //           fournisseur['nom'] == null
                    //               ? pw.Container()
                    //               : pw.Container(
                    //                   height: 15,
                    //                   child: pw.Text(
                    //                     "Fournisseur",
                    //                     style: pw.TextStyle(
                    //                       color: PdfColors.white,
                    //                     ),
                    //                   ),
                    //                   alignment: pw.Alignment.centerLeft,
                    //                   color: PdfColors.black,
                    //                   width: double.maxFinite,
                    //                 ),
                    //           fournisseur['nom'] == null
                    //               ? pw.Container()
                    //               : pw.Row(
                    //                   mainAxisAlignment:
                    //                       pw.MainAxisAlignment.start,
                    //                   children: [
                    //                     pw.Text(
                    //                         "${fournisseur['nom']} ${fournisseur['postnom']} ${fournisseur['prenom']}")
                    //                   ],
                    //                 ),
                    //           fournisseur['nom'] == null
                    //               ? pw.Container()
                    //               : pw.Row(
                    //                   mainAxisAlignment:
                    //                       pw.MainAxisAlignment.start,
                    //                   children: [
                    //                     pw.Text("${fournisseur['telephone']} ")
                    //                   ],
                    //                 ),
                    //           fournisseur['nom'] == null
                    //               ? pw.Container()
                    //               : pw.Row(
                    //                   mainAxisAlignment:
                    //                       pw.MainAxisAlignment.start,
                    //                   children: [
                    //                     pw.Text("${fournisseur['adresse']} ")
                    //                   ],
                    //                 ),
                    //         ],
                    //       );
                    //     },
                    //     build: (c) {
                    //       return [
                    //         pw.SizedBox(
                    //           height: 10,
                    //         ),
                    //         pw.SizedBox(
                    //           height: 10,
                    //         ),
                    //         pw.SizedBox(
                    //           height: 10,
                    //         ),
                    //         pw.Align(
                    //           alignment: pw.Alignment.centerLeft,
                    //           child: pw.Text(
                    //             "Poissons",
                    //             style: pw.TextStyle(
                    //               fontWeight: pw.FontWeight.bold,
                    //               fontSize: 15,
                    //             ),
                    //           ),
                    //         ),
                    //         pw.Container(
                    //           //height: 50,
                    //           //padding: pw.EdgeInsets.only(left: 10),
                    //           decoration: pw.BoxDecoration(
                    //             borderRadius: pw.BorderRadius.circular(0),
                    //             border: pw.Border.all(
                    //               color: PdfColors.grey,
                    //             ),
                    //           ),
                    //           //height: 50,
                    //           child: pw.Column(
                    //             mainAxisAlignment: pw.MainAxisAlignment.start,
                    //             children: [
                    //               pw.Container(
                    //                 height: 15,
                    //                 color: PdfColors.black,
                    //                 child: pw.Row(
                    //                   mainAxisAlignment:
                    //                       pw.MainAxisAlignment.start,
                    //                   children: [
                    //                     pw.Expanded(
                    //                       flex: 3,
                    //                       child: pw.Align(
                    //                         alignment: pw.Alignment.centerLeft,
                    //                         child:
                    //                             pw.Text("NOM", style: entete2),
                    //                       ),
                    //                     ),
                    //                     pw.Expanded(
                    //                       flex: 3,
                    //                       child: pw.Align(
                    //                         alignment: pw.Alignment.centerLeft,
                    //                         child: pw.Row(
                    //                           mainAxisAlignment:
                    //                               pw.MainAxisAlignment.start,
                    //                           children: [
                    //                             pw.Text("PRIX", style: entete2),
                    //                           ],
                    //                         ),
                    //                       ),
                    //                     ),
                    //                     pw.Expanded(
                    //                       flex: 3,
                    //                       child: pw.Align(
                    //                         alignment: pw.Alignment.centerLeft,
                    //                         child: pw.Text("QUANTITE",
                    //                             style: entete2),
                    //                       ),
                    //                     ),
                    //                     pw.Expanded(
                    //                       flex: 3,
                    //                       child: pw.Align(
                    //                         alignment: pw.Alignment.centerLeft,
                    //                         child: pw.Text("TOTAL",
                    //                             style: entete2),
                    //                       ),
                    //                     ),
                    //                     pw.Align(
                    //                       alignment: pw.Alignment.centerLeft,
                    //                       child:
                    //                           pw.Text("DEVISE", style: entete2),
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ),
                    //               pw.Column(
                    //                 children: List.generate(
                    //                   poissons.length,
                    //                   (index) {
                    //                     Map poisson = poissons[index];
                    //                     return infos2(poisson,
                    //                         "assets/FluentEmojiHighContrastTropicalFish.svg");
                    //                   },
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //         pw.SizedBox(
                    //           height: 10,
                    //         ),
                    //         pw.Align(
                    //           alignment: pw.Alignment.centerLeft,
                    //           child: pw.Text(
                    //             "Produits & Materiels",
                    //             style: pw.TextStyle(
                    //               fontWeight: pw.FontWeight.bold,
                    //               fontSize: 15,
                    //             ),
                    //           ),
                    //         ),
                    //         pw.Container(
                    //           //height: 50,
                    //           padding: pw.EdgeInsets.only(left: 0),
                    //           decoration: pw.BoxDecoration(
                    //             borderRadius: pw.BorderRadius.circular(5),
                    //             border: pw.Border.all(
                    //               color: PdfColors.grey,
                    //             ),
                    //           ),
                    //           //height: 50,
                    //           child: pw.Column(
                    //             mainAxisAlignment: pw.MainAxisAlignment.start,
                    //             children: [
                    //               pw.Container(
                    //                 height: 15,
                    //                 color: PdfColors.black,
                    //                 child: pw.Row(
                    //                   mainAxisAlignment:
                    //                       pw.MainAxisAlignment.start,
                    //                   children: [
                    //                     pw.Expanded(
                    //                       flex: 3,
                    //                       child: pw.Align(
                    //                         alignment: pw.Alignment.centerLeft,
                    //                         child:
                    //                             pw.Text("NOM", style: entete2),
                    //                       ),
                    //                     ),
                    //                     pw.Expanded(
                    //                       flex: 3,
                    //                       child: pw.Align(
                    //                         alignment: pw.Alignment.centerLeft,
                    //                         child: pw.Row(
                    //                           mainAxisAlignment:
                    //                               pw.MainAxisAlignment.start,
                    //                           children: [
                    //                             pw.Text("PRIX", style: entete2),
                    //                           ],
                    //                         ),
                    //                       ),
                    //                     ),
                    //                     pw.Expanded(
                    //                       flex: 3,
                    //                       child: pw.Align(
                    //                         alignment: pw.Alignment.centerLeft,
                    //                         child: pw.Text("QUANTITE",
                    //                             style: entete2),
                    //                       ),
                    //                     ),
                    //                     pw.Expanded(
                    //                       flex: 3,
                    //                       child: pw.Align(
                    //                         alignment: pw.Alignment.centerLeft,
                    //                         child: pw.Text("TOTAL",
                    //                             style: entete2),
                    //                       ),
                    //                     ),
                    //                     pw.Align(
                    //                       alignment: pw.Alignment.centerLeft,
                    //                       child:
                    //                           pw.Text("DEVISE", style: entete2),
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ),
                    //               pw.Column(
                    //                 children: List.generate(
                    //                   materiels.length,
                    //                   (index) {
                    //                     Map materiel = materiels[index];
                    //                     return infos2(materiel,
                    //                         "assets/SolarBoxLinear.svg");
                    //                   },
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //         pw.SizedBox(
                    //           height: 10,
                    //         ),
                    //         pw.Align(
                    //           alignment: pw.Alignment.centerLeft,
                    //           child: pw.Text(
                    //             "Faris supplementaire",
                    //             style: pw.TextStyle(
                    //               fontWeight: pw.FontWeight.bold,
                    //               fontSize: 15,
                    //             ),
                    //           ),
                    //         ),
                    //         pw.Container(
                    //           //height: 50,
                    //           //padding: pw.EdgeInsets.only(left: 10),
                    //           decoration: pw.BoxDecoration(
                    //             borderRadius: pw.BorderRadius.circular(0),
                    //             border: pw.Border.all(
                    //               color: PdfColors.grey,
                    //             ),
                    //           ),
                    //           //height: 50,
                    //           child: pw.Column(
                    //             mainAxisAlignment: pw.MainAxisAlignment.start,
                    //             children: [
                    //               pw.Container(
                    //                 height: 15,
                    //                 color: PdfColors.black,
                    //                 child: pw.Row(
                    //                   mainAxisAlignment:
                    //                       pw.MainAxisAlignment.start,
                    //                   children: [
                    //                     pw.Expanded(
                    //                       flex: 3,
                    //                       child: pw.Align(
                    //                         alignment: pw.Alignment.centerLeft,
                    //                         child: pw.Text(
                    //                           "TYPE",
                    //                           style: const pw.TextStyle(
                    //                             color: PdfColors.white,
                    //                           ),
                    //                         ),
                    //                       ),
                    //                     ),
                    //                     pw.Expanded(
                    //                       flex: 3,
                    //                       child: pw.Align(
                    //                         alignment: pw.Alignment.centerLeft,
                    //                         child: pw.Text(
                    //                           "MONTANT",
                    //                           style: const pw.TextStyle(
                    //                             color: PdfColors.white,
                    //                           ),
                    //                         ),
                    //                       ),
                    //                     ),
                    //                     pw.Expanded(
                    //                       flex: 3,
                    //                       child: pw.Align(
                    //                         alignment: pw.Alignment.centerLeft,
                    //                         child: pw.Text(
                    //                           "DEVISE",
                    //                           style: const pw.TextStyle(
                    //                             color: PdfColors.white,
                    //                           ),
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ),
                    //               pw.Column(
                    //                 children: List.generate(
                    //                   frais.length,
                    //                   (index) {
                    //                     Map f = frais[index];
                    //                     return infos1(
                    //                         f, "assets/SolarBoxLinear.svg");
                    //                   },
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //         pw.SizedBox(
                    //           height: 20,
                    //         ),
                    //       ];
                    //     },
                    //   ),
                    // );
                    // //
                    // await Printing.sharePdf(
                    //     bytes: await pdf.save(),
                    //     filename: '${journal['type']}-${journal['id']}.pdf');
                  },
                  icon: Icon(Icons.share),
                )
              ],
            ),
            body: Stack(
              children: [
                Container(
                  height: double.infinity,
                  width: double.maxFinite,
                  decoration: const BoxDecoration(
                    //color: Colors.white,
                    image: DecorationImage(
                      image: AssetImage("assets/pngegg (1).png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                    child: Opacity(
                      opacity: 0.9,
                      child: Container(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        // const Align(
                        //   alignment: Alignment.centerLeft,
                        //   child: Text(
                        //     "Agent",
                        //     style: TextStyle(
                        //       fontWeight: FontWeight.bold,
                        //       fontSize: 15,
                        //     ),
                        //   ),
                        // ),
                        bloc("Date", "$date $heure"),
                        const SizedBox(
                          height: 10,
                        ),
                        bloc("Agent",
                            "${agent['nom']} ${agent['postnom']} ${agent['prenom']}"),
                        const SizedBox(
                          height: 10,
                        ),
                        bloc("Fournisseur",
                            "${fournisseur['nom']} ${fournisseur['postnom']} ${fournisseur['prenom']}"),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 7,
                              child: bloc("Taux", "$taux"),
                            ),
                            Expanded(
                              flex: 4,
                              child: bloc("Devise", devise),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Poissons",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 7,
                              child: Container(
                                color: Colors.black,
                                width: double.maxFinite,
                                padding: const EdgeInsets.all(2),
                                child: Text(
                                  "Nom",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                color: Colors.black,
                                width: double.maxFinite,
                                padding: const EdgeInsets.all(2),
                                child: Text(
                                  "Quantité",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                color: Colors.black,
                                width: double.maxFinite,
                                padding: const EdgeInsets.all(2),
                                child: Text(
                                  "Prix",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                          ),
                          child: Column(
                            children: List.generate(poissons.length, (index) {
                              Map poisson = poissons[index];
                              return Row(
                                children: [
                                  Expanded(
                                    flex: 7,
                                    child: Container(
                                      color: Colors.white,
                                      width: double.maxFinite,
                                      padding: const EdgeInsets.all(2),
                                      child: Text(
                                        "${poisson['nom']}",
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 10),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      color: Colors.white,
                                      width: double.maxFinite,
                                      padding: const EdgeInsets.all(2),
                                      child: Text(
                                        "${poisson['quantite']}",
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 10),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      color: Colors.white,
                                      width: double.maxFinite,
                                      padding: const EdgeInsets.all(2),
                                      child: Text(
                                        "${poisson['montant']} ${poisson['devise']}",
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 10),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ),
                        ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        // const Align(
                        //   alignment: Alignment.centerLeft,
                        //   child: Text(
                        //     "Frais supplementaire",
                        //     style: TextStyle(
                        //       fontWeight: FontWeight.bold,
                        //       fontSize: 15,
                        //     ),
                        //   ),
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //   children: [
                        //     Expanded(
                        //       flex: 3,
                        //       child: bloc("Type", "2700"),
                        //     ),
                        //     Expanded(
                        //       flex: 3,
                        //       child: bloc("Montant", "2700"),
                        //     ),
                        //     Expanded(
                        //       flex: 3,
                        //       child: bloc("Devise", "2700"),
                        //     ),
                        //   ],
                        // ),
                        const SizedBox(
                          height: 10,
                        ),
                        bloc("Frais supplementaire",
                            "${frais['montant']} ${frais['devise']} ${frais['remarque']}"),

                        const SizedBox(
                          height: 20,
                        ),

                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Signature responsable",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Signature fournisseur",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),

                        ElevatedButton(
                          onPressed: () async {
                            //Loader.attente();
                            final pdf = pw.Document();

                            pdf.addPage(
                              pw.MultiPage(
                                //margin: const pw.EdgeInsets.all(3),
                                //pageFormat: PdfPageFormat.a6,
                                header: (c) {
                                  //
                                  return pw.Column(
                                    children: [
                                      pw.Row(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.spaceBetween,
                                        children: [
                                          pw.Expanded(
                                            flex: 3,
                                            child: pw.Text(
                                                "${journal['date']}   ${journal['heure']}"),
                                          ),
                                          pw.Expanded(
                                            flex: 3,
                                            child: pw.Center(
                                              child: pw.Text("AquaTropical"),
                                            ),
                                          ),
                                          pw.Expanded(
                                            flex: 3,
                                            child: pw.Container(
                                              alignment:
                                                  pw.Alignment.centerRight,
                                              child: pw.Text(
                                                  "N° ${journal['id']}"),
                                            ),
                                          ),
                                        ],
                                      ),
                                      pw.Container(
                                        margin: pw.EdgeInsets.all(1),
                                        height: 2,
                                        width: double.maxFinite,
                                        color: PdfColors.black,
                                      ),
                                      pw.Container(
                                        margin: pw.EdgeInsets.all(1),
                                        height: 2,
                                        width: double.maxFinite,
                                        color: PdfColors.black,
                                      ),
                                      pw.SizedBox(
                                        height: 10,
                                      ),
                                      pw.Row(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.center,
                                        children: [
                                          pw.Text(
                                            "Facture poisson",
                                            style: pw.TextStyle(
                                                fontWeight: pw.FontWeight.bold),
                                          )
                                        ],
                                      ),

                                      //
                                      pw.SizedBox(height: 10),
                                    ],
                                  );
                                },
                                build: (c) {
                                  return [
                                    pw.SizedBox(
                                      height: 10,
                                    ),
                                    pw.SizedBox(
                                      height: 10,
                                    ),
                                    // const Align(
                                    //   alignment: Alignment.centerLeft,
                                    //   child: Text(
                                    //     "Agent",
                                    //     style: TextStyle(
                                    //       fontWeight: FontWeight.bold,
                                    //       fontSize: 15,
                                    //     ),
                                    //   ),
                                    // ),
                                    bloc2("Date", "$date $heure"),
                                    pw.SizedBox(
                                      height: 10,
                                    ),
                                    bloc2("Agent",
                                        "${agent['nom']} ${agent['postnom']} ${agent['prenom']}"),
                                    pw.SizedBox(
                                      height: 10,
                                    ),
                                    bloc2("Fournisseur",
                                        "${fournisseur['nom']} ${fournisseur['postnom']} ${fournisseur['prenom']}"),
                                    pw.SizedBox(
                                      height: 10,
                                    ),
                                    pw.Row(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.spaceBetween,
                                      children: [
                                        pw.Expanded(
                                          flex: 7,
                                          child: bloc2("Taux", "$taux"),
                                        ),
                                        pw.Expanded(
                                          flex: 4,
                                          child: bloc2("Devise", devise),
                                        ),
                                      ],
                                    ),
                                    pw.SizedBox(
                                      height: 20,
                                    ),
                                    pw.Align(
                                      alignment: pw.Alignment.centerLeft,
                                      child: pw.Text(
                                        "Poissons",
                                        style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    pw.Row(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.spaceBetween,
                                      children: [
                                        pw.Expanded(
                                          flex: 7,
                                          child: pw.Container(
                                            color: PdfColors.black,
                                            width: double.maxFinite,
                                            padding: pw.EdgeInsets.all(2),
                                            child: pw.Text(
                                              "Nom",
                                              style: pw.TextStyle(
                                                  color: PdfColors.white),
                                            ),
                                          ),
                                        ),
                                        pw.Expanded(
                                          flex: 2,
                                          child: pw.Container(
                                            color: PdfColors.black,
                                            width: double.maxFinite,
                                            padding: pw.EdgeInsets.all(2),
                                            child: pw.Text(
                                              "Quantité",
                                              style: pw.TextStyle(
                                                  color: PdfColors.white),
                                            ),
                                          ),
                                        ),
                                        pw.Expanded(
                                          flex: 3,
                                          child: pw.Container(
                                            color: PdfColors.black,
                                            width: double.maxFinite,
                                            padding: pw.EdgeInsets.all(2),
                                            child: pw.Text(
                                              "Prix",
                                              style: pw.TextStyle(
                                                  color: PdfColors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    pw.Container(
                                      decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            color: PdfColors.black, width: 1),
                                      ),
                                      child: pw.Column(
                                        children: List.generate(poissons.length,
                                            (index) {
                                          Map poisson = poissons[index];
                                          return pw.Row(
                                            children: [
                                              pw.Expanded(
                                                flex: 7,
                                                child: pw.Container(
                                                  color: PdfColors.white,
                                                  width: double.maxFinite,
                                                  padding: pw.EdgeInsets.all(2),
                                                  child: pw.Text(
                                                    "${poisson['nom']}",
                                                    style: pw.TextStyle(
                                                        color: PdfColors.black),
                                                  ),
                                                ),
                                              ),
                                              pw.Expanded(
                                                flex: 2,
                                                child: pw.Container(
                                                  alignment:
                                                      pw.Alignment.centerLeft,
                                                  color: PdfColors.white,
                                                  width: double.maxFinite,
                                                  padding: pw.EdgeInsets.all(2),
                                                  child: pw.Text(
                                                    "${poisson['quantite']}",
                                                    style: pw.TextStyle(
                                                        color: PdfColors.black),
                                                  ),
                                                ),
                                              ),
                                              pw.Expanded(
                                                flex: 3,
                                                child: pw.Container(
                                                  alignment:
                                                      pw.Alignment.centerLeft,
                                                  color: PdfColors.white,
                                                  width: double.maxFinite,
                                                  padding: pw.EdgeInsets.all(2),
                                                  child: pw.Text(
                                                    "${poisson['montant']} ${poisson['devise']}",
                                                    style: pw.TextStyle(
                                                        color: PdfColors.black),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        }),
                                      ),
                                    ),
                                    pw.SizedBox(
                                      height: 10,
                                    ),
                                    bloc2("Frais supplementaire",
                                        "${frais['montant']} ${frais['devise']} ${frais['remarque']}"),

                                    pw.SizedBox(
                                      height: 20,
                                    ),

                                    pw.Row(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.spaceAround,
                                      children: [
                                        pw.Align(
                                          alignment: pw.Alignment.centerLeft,
                                          child: pw.Text(
                                            "Signature responsable",
                                            style: pw.TextStyle(
                                              fontWeight: pw.FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        pw.Align(
                                          alignment: pw.Alignment.centerLeft,
                                          child: pw.Text(
                                            "Signature fournisseur",
                                            style: pw.TextStyle(
                                              fontWeight: pw.FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    pw.SizedBox(
                                      height: 50,
                                    ),
                                  ];
                                },
                              ),
                            );
                            //
                            await Printing.layoutPdf(
                                onLayout: (PdfPageFormat format) async =>
                                    pdf.save());
                            //
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.green.shade700),
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
                              "Imprimer",
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
              ],
            ),
          );
        } else if (t.hasError) {
          return Scaffold(
            appBar: AppBar(),
            body: Container(),
          );
        }
        return Scaffold(
          body: Center(
            child: Container(
              height: 40,
              width: 40,
              child: const CircularProgressIndicator(),
            ),
          ),
        );
      }),
    );
  }

  //
  Widget bloc(String titre, String valeur) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: Colors.black,
            width: double.maxFinite,
            padding: const EdgeInsets.all(2),
            child: Text(
              titre,
              style: const TextStyle(color: Colors.white, fontSize: 10),
            ),
          ),
          Container(
            color: Colors.white,
            width: double.maxFinite,
            padding: const EdgeInsets.all(2),
            child: Text(
              valeur,
              style: const TextStyle(color: Colors.black, fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }

  //
  pw.Widget bloc2(String titre, String valeur) {
    return pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.black, width: 1),
      ),
      child: pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.center,
        children: [
          pw.Container(
            color: PdfColors.black,
            width: double.maxFinite,
            padding: pw.EdgeInsets.all(2),
            child: pw.Text(
              titre,
              style: pw.TextStyle(color: PdfColors.white, fontSize: 10),
            ),
          ),
          pw.Container(
            color: PdfColors.white,
            width: double.maxFinite,
            padding: pw.EdgeInsets.all(2),
            child: pw.Text(
              valeur,
              style: pw.TextStyle(color: PdfColors.black, fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }

  //
  //
  pw.TextStyle entete1 = pw.TextStyle(
    fontSize: 7,
    fontWeight: pw.FontWeight.normal,
  );

  //
  pw.TextStyle entete2 = pw.TextStyle(
      fontSize: 7, fontWeight: pw.FontWeight.bold, color: PdfColors.white);
  //
  pw.Container infos1(Map f, String path) {
    return pw.Container(
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.start,
        children: [
          pw.Expanded(
            flex: 3,
            child: pw.Align(
              alignment: pw.Alignment.centerLeft,
              child: pw.Text(
                "${f['type']}",
                //style: entete2,
              ),
            ),
          ),
          pw.Expanded(
            flex: 3,
            child: pw.Align(
              alignment: pw.Alignment.centerLeft,
              child: pw.Text("${f['montant']} "),
            ),
          ),
          pw.Expanded(
            flex: 3,
            child: pw.Align(
              alignment: pw.Alignment.centerLeft,
              child: pw.Text(
                "${f['devise']} ",
              ),
            ),
          ),
        ],
      ),
    );
  }

  //
  pw.Container infos2(Map poisson, String path) {
    return pw.Container(
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.start,
        children: [
          pw.Expanded(
            flex: 3,
            child: pw.Align(
              alignment: pw.Alignment.centerLeft,
              child: pw.Text(
                "${poisson['nom']}",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.normal,
                  fontSize: 7,
                ),
              ),
            ),
          ),
          pw.Expanded(
            flex: 3,
            child: pw.Align(
              alignment: pw.Alignment.centerLeft,
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Text(
                    "${poisson['prix']}",
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.normal,
                      fontSize: 7,
                    ),
                  ),
                ],
              ),
            ),
          ),
          pw.Expanded(
            flex: 3,
            child: pw.Align(
              alignment: pw.Alignment.centerLeft,
              child: pw.Text(
                "${poisson['quantite']}",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.normal,
                  fontSize: 7,
                ),
              ),
            ),
          ),
          pw.Expanded(
            flex: 3,
            child: pw.Container(
              alignment: pw.Alignment.centerLeft,
              //color: PdfColors.amber,
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Text(
                    "${poisson['quantite'] * poisson['prix']}",
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.normal,
                      fontSize: 7,
                    ),
                  )
                ],
              ),
            ),
          ),
          pw.Align(
            alignment: pw.Alignment.centerLeft,
            child: pw.Text(
              "    USD",
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.normal,
                fontSize: 7,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //
}
