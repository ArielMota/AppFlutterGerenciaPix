import 'dart:convert';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Obx(() => controller.pix.value.id != null
            ? FloatingActionButton(
                onPressed: () {
                  controller.verificaStatusPix();
                },
                child: !controller.loadingStatus.value
                    ? Icon(Icons.restart_alt_outlined)
                    : CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      ),
              )
            : Container()),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
                  child: SafeArea(
            child: Container(
              height: Get.height,
              width: Get.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.white, Colors.blue.shade100])),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/marcapix.png',
                    width: Get.width * 0.60,
                  ),
                  Container(
                    width: Get.width * 0.65,
                    margin: EdgeInsets.all(15),
                    child: TextFormField(
                      controller: controller.valorctrl,
                      focusNode: controller.focusNode,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        CentavosInputFormatter()
                      ],
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          labelText: 'Digite o valor da cobrança',
                          fillColor: Colors.white70),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    height: Get.height * 0.06,
                    width: Get.width * 0.65,
                    child: Obx(() => ElevatedButton(
                          child: !controller.loadingGeraCobranca.value
                              ? Text('Gerar Cobrança')
                              : CircularProgressIndicator(
                                  backgroundColor: Colors.white,
                                ),
                          onPressed: () {
                            controller.geraPixQrCode();
                          },
                        )),
                  ),
                  Obx(() => Center(
                      child: controller.pix.value.qr_code_base64 != null
                          ? Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.all(20),
                                  child: Image.memory(Base64Decoder().convert(
                                      controller.pix.value.qr_code_base64 ?? ""), width: Get.width * 0.8,),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Valor: \$ ",
                                          style: TextStyle(fontSize: 20)),
                                      Text(
                                          controller.pix.value.transaction_amount!
                                              .toStringAsFixed(2),
                                          style: TextStyle(fontSize: 20))
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "Status do Pagamento:",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      traduzirStatus(
                                          controller.status.value),
                                      style: TextStyle(
                                          fontSize: 35,
                                          fontWeight: FontWeight.bold,
                                          color: corStatus(
                                              controller.status.value)),
                                    )
                                  ],
                                )
                              ],
                            )
                          : Container())),
                ],
              ),
            ),
          ),
        ));
  }

  Color corStatus(String status) {
    if (status == 'approved') {
      return Colors.green;
    } else if (status == 'pending') {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  String traduzirStatus(String status) {
    print(status);

    if (status == 'approved') {
      return "Aprovado";
    } else if (status == 'pending') {
      return "Pendente";
    } else {
      return 'Expirado';
    }
  }
}
