import 'package:get/get.dart';

class ExpeditionController extends GetxController with StateMixin<List> {
  //
  load() async {
    change([], status: RxStatus.empty());
  }
}
