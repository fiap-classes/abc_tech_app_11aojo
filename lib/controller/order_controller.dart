import 'package:abc_tech_app/model/assist.dart';
import 'package:abc_tech_app/model/order.dart';
import 'package:abc_tech_app/model/order_location.dart';
import 'package:abc_tech_app/service/geolocation_service.dart';
import 'package:abc_tech_app/service/order_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'dart:developer';

enum OrderState { creating, started, finished }

class OrderController extends GetxController with StateMixin<bool> {
  final GeolocationServiceInterface _geolocationService;
  final OrderServiceInterface _orderService;
  final formKey = GlobalKey<FormState>();
  final operatorIdController = TextEditingController();
  final selectedAssists = <Assist>[].obs;
  late Order? _order;
  final screenState = OrderState.creating.obs;
  OrderController(this._geolocationService, this._orderService);

  @override
  void onInit() {
    super.onInit();
    _geolocationService.start();
  }

  @override
  void onReady() {
    change(true, status: RxStatus.success());
  }

  getLocation() {
    _geolocationService
        .getPosition()
        .then((value) => log(value.toJson().toString()));
  }

  editAssist() {
    Get.toNamed("/services", arguments: selectedAssists);
  }

  finishStartOrder() {
    switch (screenState.value) {
      case OrderState.creating:
        change(true, status: RxStatus.loading());
        _geolocationService.getPosition().then((value) {
          var start = OrderLocation(
              latitude: value.latitude,
              longitude: value.longitude,
              dateTime: DateTime.now());
          List<int> assists =
              selectedAssists.map((element) => element.id).toList();
          _order = Order(
              operatorId: int.parse(operatorIdController.text),
              services: assists);
          _order!.start = start;
          screenState.value = OrderState.started;
          change(true, status: RxStatus.success());
        });
        break;
      case OrderState.started:
        _geolocationService.getPosition().then((value) {
          var end = OrderLocation(
              latitude: value.latitude,
              longitude: value.longitude,
              dateTime: DateTime.now());
          _order!.end = end;
          screenState.value = OrderState.finished;
          _createOrder();
        });
        break;
      case OrderState.finished:
        break;
    }
  }

  void _createOrder() {
    change(true, status: RxStatus.loading());
    _orderService.createOrder(_order!).then((value) {
      if (value) {
        Get.snackbar("Sucesso", "Ordem criada com sucesso!",
            backgroundColor: Colors.green);
      } else {
        Get.snackbar("Erro", "Problema ao criar ordem",
            backgroundColor: Colors.red);
      }
      clearForm();
    }).onError((error, stackTrace) {
      Get.snackbar("Erro", "Problema ao criar ordem",
          backgroundColor: Colors.red);
      clearForm();
    });
  }

  void clearForm() {
    operatorIdController.text = "";
    _order = null;
    selectedAssists.clear();
    screenState.value = OrderState.creating;
    change(true, status: RxStatus.success());
  }
}
