import 'dart:convert';

import 'package:aquatropical_agent/utils/requete.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class JournalController extends GetxController with StateMixin<List> {
  //
  Requete requete = Requete();
  //
  var box = GetStorage();
  //
  RxMap agent = {}.obs;
  RxMap poisson = {}.obs;
  RxList poissons = [].obs;
  RxList materiels = [].obs;
  RxMap fournisseur = {}.obs;
  RxMap fraisSupplementaire = {}.obs;
  //
  getTaux() async {
    Response response = await requete.getE("devise");
    if (response.isOk) {
      //print("taux: ${response.body}");
      box.write("taux", response.body);
    } else {
      //
      box.write("taux", 0);
    }
  }

  //
  getForMonth(String mois, String annee) async {
    //
    change([], status: RxStatus.loading());
    //
    Response response =
        await requete.getE("journal/mois?mois=$mois&annee=$annee");
    //
    if (response.isOk) {
      //print("saisie: ${response.body}");
      //
      change(response.body, status: RxStatus.success());
    } else {
      //
      //print("saisie: ${response.statusCode} :: ${response.body}");
      change([], status: RxStatus.empty());
    }
  }

  //
  getForDay(String dateTime) async {
    //
    change([], status: RxStatus.loading());
    //
    Response response = await requete.getE("facture/all/jour/$dateTime");
    //
    if (response.isOk) {
      //
      change(response.body, status: RxStatus.success());
    } else {
      //
      change([], status: RxStatus.empty());
    }
  }

  //
  enregistrement(Map journal, String dateTime) async {
    //
    change([], status: RxStatus.loading());
    //
    Response response = await requete.postE("journal", journal);
    //
    if (response.isOk) {
      //
      fournisseur.value = {};
      //
      materiels.value = [];
      //
      poissons.value = [];
      //
      fraisSupplementaire.value = {};
      //
      Get.back();
      Get.snackbar("Succès", "Enregistrement éffectué");
      List<String> l = dateTime.split("-");
      getForMonth(l[1], l[2]);
    } else {
      //
      Get.back();
      Get.snackbar(
          "Oups", "Enregistrement non éffectué code: ${response.statusCode}");
      List<String> l = dateTime.split("-");
      getForMonth(l[1], l[2]);
    }
  }

  //
  enregistrement2(List journaux, String dateTime) async {
    //
    change([], status: RxStatus.loading());
    //
    Response response = await requete.postE("journal/poissons", journaux);
    //
    if (response.isOk) {
      //
      fournisseur.value = {};
      //
      materiels.value = [];
      //
      poissons.value = [];
      //
      fraisSupplementaire.value = {};
      //
      Get.back();
      Get.snackbar("Succès", "Enregistrement éffectué");
      List<String> l = dateTime.split("-");
      getForMonth(l[1], l[2]);
    } else {
      //
      Get.back();
      Get.snackbar(
          "Oups", "Enregistrement non éffectué code: ${response.statusCode}");
      List<String> l = dateTime.split("-");
      getForMonth(l[1], l[2]);
    }
  }

  //
  Future<Map> getAgent(String id) async {
    //
    //
    Response response = await requete.getE("agent/one/$id");
    //
    if (response.isOk) {
      //
      return response.body;
    } else {
      //
      return {};
    }
  }

  //
  Future<Map> getFacture(String id) async {
    //
    //
    Response response = await requete.getE("journal/facture?idFacture=$id");
    //
    if (response.isOk) {
      //
      return response.body;
    } else {
      //
      return {};
    }
  }

  //
  Future<Map> getSolde() async {
    //
    //
    Response response = await requete.getE("solde/solde");
    //
    if (response.isOk) {
      //
      return response.body;
    } else {
      //
      return {};
    }
  }
}
