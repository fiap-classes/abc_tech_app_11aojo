import 'package:abc_tech_app/model/assist.dart';
import 'package:abc_tech_app/provider/assist_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/utils.dart';

class AssistanceService extends GetxService {
  late AssistanceProviderInterface _assistanceProvider;

  AssistanceService init(AssistanceProviderInterface providerInterface) {
    _assistanceProvider = providerInterface;
    return this;
  }

  Future<List<Assist>> getAssists() async {
    Response response = await _assistanceProvider.getAssists();
    if (response.hasError) {
      return Future.error(ErrorDescription("Erro na conexão"));
    }

    try {
      List<Assist> list =
          response.body.map<Assist>((item) => Assist.fromMap(item)).toList();
      return Future.sync(() => list);
    } catch (e) {
      e.printError();
      return Future.error(ErrorDescription(e.toString()));
    }
  }
}
