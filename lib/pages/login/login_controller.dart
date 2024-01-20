import 'package:aquatropical_agent/pages/accueil.dart';
import 'package:aquatropical_agent/utils/requete.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController with StateMixin<List> {
  //
  Requete requete = Requete();
  //
  var box = GetStorage();
  //
  loagingAgent(String telephone, String mdp) async {
    //
    change([], status: RxStatus.loading());
    //
    Response response = await requete.getE("agent/login/$telephone/$mdp");
    //
    if (response.isOk) {
      //
      box.write("user", response.body);
      //
      Get.back();
      Get.snackbar("Succès", "Bienvenu agent");
      Get.offAll(Accueil());
    } else {
      //
      Get.back();
      Get.snackbar("Oups", "Log non éffectué code: ${response.statusCode}");
    }
  }

  //
}
