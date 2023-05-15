import 'package:abc_tech_app/constants.dart';
import 'package:abc_tech_app/model/order.dart';
import 'package:get/get.dart';

abstract class OrderProviderInterface {
  Future<Response> postOrder(Order order);
}

class OrderProvider extends GetConnect implements OrderProviderInterface {
  @override
  Future<Response> postOrder(Order order) =>
      post('${Constants.url}/order', order.toMap());
}
