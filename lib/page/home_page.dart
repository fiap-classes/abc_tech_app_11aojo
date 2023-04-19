import 'package:abc_tech_app/controller/assistance_controller.dart';
import 'package:abc_tech_app/model/assist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class HomePage extends GetView<AssistanceController> {
  const HomePage({super.key});

  Widget _renderAssists(List<Assist> assists) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: assists.length,
        itemBuilder: (context, index) =>
            ListTile(title: Text(assists[index].title)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("ABC Tech App")),
        body: Container(
          constraints: const BoxConstraints.expand(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: const [
                    Expanded(
                        child: Text(
                      "Os serviços disponíveis são:",
                      textAlign: TextAlign.center,
                    ))
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                        child: TextButton(
                            onPressed: controller.getAssistanceList,
                            child: const Text("Carregar")))
                  ],
                ),
                controller.obx((state) => _renderAssists(state ?? []),
                    onLoading: const CircularProgressIndicator(),
                    onEmpty: const Text("Nenhum serviço disponível"),
                    onError: (error) => Text(error.toString()))
              ],
            ),
          ),
        ));
  }
}
