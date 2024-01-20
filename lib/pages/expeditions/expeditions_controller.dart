import 'package:aquatropical_agent/utils/requete.dart';
import 'package:get/get.dart';

class ExpeditionController extends GetxController with StateMixin<List> {
  //
  Requete requete = Requete();
  //
  RxList poissons = [].obs;
  RxList poissonsExp = [].obs;
  //
  RxList materiels = [].obs;
  RxList fraisSupplementaire = [].obs;
  //
  load() async {
    change([], status: RxStatus.empty());
  }
  //

  getForMonth(String date) async {
    //
    change([], status: RxStatus.loading());
    //
    Response response = await requete.getE("expedition/all/mois/$date");
    //
    if (response.isOk) {
      //
      print("response.body: ${response.body}");
      change(response.body, status: RxStatus.success());
    } else {
      //
      change([], status: RxStatus.empty());
    }
  }

  //
  getForDay(String dateTime) async {
    //
    change([], status: RxStatus.loading());
    //
    Response response = await requete.getE("expedition/all/jour/$dateTime");
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
  updateExpedition(Map journal, String dateTime) async {
    //
    change([], status: RxStatus.loading());
    //
    Response response = await requete.putE("expedition", journal);
    //
    if (response.isOk) {
      //
      //fournisseur.value = {};
      //
      materiels.value = [];
      //
      poissons.value = [];
      //
      fraisSupplementaire.value = [];
      //
      Get.back();
      Get.snackbar("Succès", response.bodyString!);
      getForMonth(dateTime);
    } else {
      //
      Get.back();
      Get.snackbar(
          "Oups", "Enregistrement non éffectué code: ${response.statusCode}");
      getForMonth(dateTime);
    }
  }
}
