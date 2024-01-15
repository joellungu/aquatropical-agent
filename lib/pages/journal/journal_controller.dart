import 'package:aquatropical_agent/utils/requete.dart';
import 'package:get/get.dart';

class JournalController extends GetxController with StateMixin<List> {
  //
  Requete requete = Requete();
  //
  RxList poissons = [].obs;
  //
  getForMonth(String dateTime) async {
    //
    change([], status: RxStatus.loading());
    //
    Response response = await requete.getE("poisson/all");
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
}
