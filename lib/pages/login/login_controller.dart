import 'package:aquatropical_agent/utils/requete.dart';
import 'package:get/get.dart';

class LoginController extends GetxController with StateMixin<List> {
  //
  Requete requete = Requete();

  //
  loagingAgent(String telephone, String mdp) async {
    //
    change([], status: RxStatus.loading());
    //
    Response response = await requete.getE("fournisseur");
    //
    if (response.isOk) {
      //
      Get.back();
      Get.snackbar("Succès", "Bienvenu agent");
    } else {
      //
      Get.back();
      Get.snackbar(
          "Oups", "Enregistrement non éffectué code: ${response.statusCode}");
    }
  }

  //
}
