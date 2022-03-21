import 'dart:ffi';

import 'package:gerencia_pix/app/data/base_url.dart';
import 'package:get/get.dart';
import 'dart:convert';

 

class PixProvider extends GetConnect{

  /*Future<Map<String, dynamic>> buscarTodosProdutos() async {
    var response;
    try {
       response = await httpClient.get(base_url);

      if (response.body != null) {
             // print(response.body);

        return response.body;
      } else {
        print("erro -post: " + response.body);
        return response.body;
      }
    } catch (e) {
      print(e);
    }
    return response.body;
  }*/
Future<Map<String, dynamic>> geraPixQrCode(num valor) async {
     late var response = null;
    try {
       response = await httpClient.get(base_url + "gerarpix/" + '$valor');

      if (response.body != null) {
   // print(response.body);

        return response.body;
      } else {

        return {"id": null, "qr_code_base64": null};
      }
    } catch (e) {
      print(e);
    }
    return {"erro":"Não foi possivel acessar o servidor!"};
  }

  Future<Map<String, dynamic>> verificarStatusPix(int id) async {
     late var response = null;
    try {
       response = await httpClient.get(base_url + "verificarstatuspix/" + '$id');

      if (response.body != null) {
   // print(response.body);

        return response.body;
      } else {

        return {"status": null};
      }
    } catch (e) {
      print(e);
    }
    return {"erro":"Não foi possivel acessar o servidor!"};
  }


}