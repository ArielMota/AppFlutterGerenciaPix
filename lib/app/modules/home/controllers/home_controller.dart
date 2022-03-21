import 'package:flutter/material.dart';
import 'package:gerencia_pix/app/data/model/pix.dart';
import 'package:gerencia_pix/app/data/repository/pix_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  final pixRepository = Get.find<PixRepository>();

  late Rx<Pix> pix = Rx(Pix());
  late Rx<String> status = Rx<String>('');

  late TextEditingController valorctrl;
  late FocusNode focusNode;
  late Rx<bool> loadingGeraCobranca;
  late Rx<bool> loadingStatus;

  final count = 0.obs;
  @override
  void onInit() {
    valorctrl = TextEditingController();
    focusNode = FocusNode();
    loadingGeraCobranca = Rx(false);
    loadingStatus = Rx(false);

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  Future<void> geraPixQrCode() async {
    if (valorctrl.text != "") {
      loadingGeraCobranca.value = true;
      pix.value = await pixRepository
          .geraPixQrCode(num.parse(valorctrl.text.replaceAll(",", ".")));
      status.value = pix.value.status!;

      focusNode.unfocus();

      print(valorctrl.text.replaceAll(",", "."));
      loadingGeraCobranca.value = false;
    }
  }

  Future<void> verificaStatusPix() async {
    loadingStatus.value = true;

    await pixRepository.verificarStatusPix(pix.value.id!).then((value) {
      status.value = value.status!;
    });
    loadingStatus.value = false;
  }
}
