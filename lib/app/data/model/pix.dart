import 'dart:ffi';

class Pix {
  int? id;
  String? qr_code_base64;
  num? valor;
  String? status;
  num? transaction_amount;

  Pix(
      {this.id,
      this.qr_code_base64,
      this.valor,
      this.status,
      this.transaction_amount});

  Pix.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    qr_code_base64 = json['qr_code_base64'];
    valor = json['valor'];
    status = json['status'];
    transaction_amount = json['transaction_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['qr_code_base64'] = this.qr_code_base64;
    data['valor'] = this.valor;
    data['status'] = this.status;
    data['transaction_amount'] = this.transaction_amount;

    return data;
  }
}
