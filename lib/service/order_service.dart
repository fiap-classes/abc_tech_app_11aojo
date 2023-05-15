import 'package:abc_tech_app/model/order.dart';
import 'package:abc_tech_app/provider/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class OrderServiceInterface {
  Future<bool> createOrder(Order order);
}

class OrderService extends GetxService implements OrderServiceInterface {
  final OrderProviderInterface _orderProvider;
  OrderService(this._orderProvider);

  @override
  Future<bool> createOrder(Order order) async {
    try {
      Response response = await _orderProvider.postOrder(order);
      if (response.hasError) {
        return Future.error(ErrorDescription("Erro na conexão"));
      }
      return Future.sync(() => true);
    } catch (e) {
      e.printInfo();
      return Future.error(ErrorDescription("Erro não esperado"));
    }
  }
}
