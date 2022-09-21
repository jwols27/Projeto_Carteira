import 'package:projeto_carteira/features/models/movimento_abs.dart';

class EntradaModel extends Movimento {
  EntradaModel(
      {int? codigo,
      int? pessoa,
      DateTime? data_entrada,
      String? desc,
      double? valor})
      : super(codigo, pessoa, data_entrada, desc, valor);

  @override
  Map<String, dynamic> toMap() {
    return {
      'codigo': codigo,
      'pessoa': pessoa,
      'data_entrada': data.toString(),
      'desc': descricao,
      'valor': valor,
    };
  }

  @override
  String toString() {
    return 'EntradaModel{codigo: $codigo, pessoa: $pessoa, data_entrada: $data, desc: $descricao, valor: $valor}';
  }

  factory EntradaModel.fromJson(Map<String, dynamic> json) {
    return EntradaModel(
        codigo: json['codigo'],
        pessoa: json['pessoa'],
        data_entrada: json['data_entrada'],
        desc: json['desc'],
        valor: json['valor']);
  }
}
