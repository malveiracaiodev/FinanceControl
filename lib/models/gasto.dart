class Gasto {
  final int? id;
  final String descricao;
  final double valor;

  Gasto({this.id, required this.descricao, required this.valor});

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'descricao': descricao,
      'valor': valor,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  factory Gasto.fromMap(Map<String, dynamic> map) {
    return Gasto(
      id: map['id'],
      descricao: map['descricao'],
      valor: map['valor'] is int ? (map['valor'] as int).toDouble() : map['valor'],
    );
  }
}
