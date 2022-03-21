import 'dart:ffi';

import 'package:gerencia_pix/app/data/model/pix.dart';
import 'package:gerencia_pix/app/data/provider/pix_provider.dart';

class PixRepository {
  final PixProvider pixProvider = PixProvider();

  /*Future<List<Produto>> buscarProdutos() async {
    Map map = await cursoProvider.buscarTodosProdutos();
    List<Produto>? listprodutos=[];
      listprodutos = decodeProduto(map);


    return listprodutos;
  }*/

  /*List<Produto> decodeProduto(Map map) {

    late List list = map["produtos"];
    
    late List<Produto> listProdutos = [];

      list.forEach((osMap) {
        listProdutos.add(Produto.fromJson(osMap));
      });

    
    return listProdutos;
  }*/

  Future<Pix> geraPixQrCode(num valor) async {
    Pix? pix;

    await pixProvider.geraPixQrCode(valor).then((value) {
      pix = Pix.fromJson(value);
    });

    print(pix!.toJson());

      return pix!;

  }

  Future<Pix> verificarStatusPix(int id) async {
    Pix? pix;

    await pixProvider.verificarStatusPix(id).then((value) {
      pix = Pix.fromJson(value);
    });

    print(pix!.toJson());

      return pix!;

  }

}
