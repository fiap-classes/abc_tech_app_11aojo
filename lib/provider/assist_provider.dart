import 'package:abc_tech_app/constants.dart';
import 'package:get/get_connect.dart';

abstract class AssistanceProviderInterface {
  Future<Response> getAssists();
}

class AssistanceProvider extends GetConnect
    implements AssistanceProviderInterface {
  @override
  Future<Response> getAssists() => get('${Constants.url}/assists');
}
