import 'package:abc_tech_app/page/home_bind.dart';
import 'package:abc_tech_app/page/home_page.dart';
import 'package:abc_tech_app/provider/assist_provider.dart';
import 'package:abc_tech_app/service/assist_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  initServices();
  runApp(const MyApp());
}

void initServices() {
  Get.put<AssistanceService>(AssistanceService().init(AssistanceProvider()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.red,
            textTheme: const TextTheme(
                headlineLarge: TextStyle(color: Colors.red, fontSize: 60))),
        getPages: [
          GetPage(name: "/", page: () => const HomePage(), binding: HomeBind())
        ]);
  }
}
