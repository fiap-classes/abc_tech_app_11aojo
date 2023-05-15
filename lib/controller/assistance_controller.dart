import 'package:abc_tech_app/model/assist.dart';
import 'package:abc_tech_app/service/assist_service.dart';
import 'package:get/get.dart';

class AssistanceController extends GetxController
    with StateMixin<List<Assist>> {
  late AssistanceService _assistanceService;
  List<Assist> allAssists = [];
  List<Assist> selectedAssists = [];

  @override
  void onInit() {
    super.onInit();
    _assistanceService = Get.find<AssistanceService>();
    getAssistanceList();
  }

  @override
  void onReady() {
    super.onReady();
    selectedAssists = Get.arguments;
  }

  void selectAssist(int index) {
    Assist assist = allAssists[index];
    int indexFound =
        selectedAssists.indexWhere((element) => element.id == assist.id);

    if (indexFound == -1) {
      selectedAssists.add(assist);
    } else {
      selectedAssists.removeAt(indexFound);
    }
    change(allAssists, status: RxStatus.success());
  }

  bool isSelected(int index) {
    Assist assist = allAssists[index];
    int indexFound =
        selectedAssists.indexWhere((element) => element.id == assist.id);
    return (indexFound != -1);
  }

  void getAssistanceList() {
    change(null, status: RxStatus.loading());

    _assistanceService.getAssists().then((value) {
      allAssists.addAll(value);
      change(value, status: RxStatus.success());
    }).onError((error, stackTrace) {
      change([], status: RxStatus.error());
    });
  }
}
