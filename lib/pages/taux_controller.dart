import 'package:aquatropical_agent/utils/requete.dart';
import 'package:get/get.dart';

class TauxController extends GetxController with StateMixin<double> {
  //
  Requete requete = Requete();
  //
  getTaux() async {
    Response response = await requete.getE("devise");
    if (response.isOk) {
      change(response.body, status: RxStatus.success());
    } else {
      //
      change(0, status: RxStatus.empty());
    }
  }

  //
  Future<double> getTaux2() async {
    Response response = await requete.getE("devise");
    if (response.isOk) {
      return response.body;
    } else {
      //
      return 1;
    }
  }

  setTaux(String taux) async {
    print("taux: $taux");
    Response response = await requete.putE("devise", taux);
    if (response.isOk) {
      Get.back();
      Get.back();
      getTaux();
      Get.snackbar("Succes", "Taux modifier avec succès");
    } else {
      Get.back();
      getTaux();
      Get.snackbar("Oups", "Taux non modifier code: ${response.statusCode}");
    }
  }
}
