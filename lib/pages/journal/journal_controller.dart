import 'package:aquatropical_agent/utils/requete.dart';
import 'package:get/get.dart';

class JournalController extends GetxController with StateMixin<List> {
  //
  Requete requete = Requete();
  //
  RxList poissons = [].obs;
  RxList materiels = [].obs;
  RxMap fournisseur = {}.obs;
  RxList fraisSupplementaire = [].obs;
  //
  getForMonth(String dateTime) async {
    //
    change([], status: RxStatus.loading());
    //
    Response response = await requete.getE("facture/all/mois/$dateTime");
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
    Response response = await requete.postE("facture", journal);
    //
    if (response.isOk) {
      //
      fournisseur.value = {};
      //
      materiels.value = [];
      //
      poissons.value = [];
      //
      fraisSupplementaire.value = [];
      //
      Get.back();
      Get.snackbar("Succès", "Enregistrement éffectué");
      getForMonth(dateTime);
    } else {
      //
      Get.back();
      Get.snackbar(
          "Oups", "Enregistrement non éffectué code: ${response.statusCode}");
      getForMonth(dateTime);
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
}
