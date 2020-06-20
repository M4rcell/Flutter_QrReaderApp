
class ScanModel {
    ScanModel({
        this.id,
        this.tipo,
        this.valor,
    }){
      if (valor.contains('http')) {
        this.tipo='http';
        
      }
      else{
        this.tipo='geo';
      }
    }

    int id;
    String tipo;
    String valor;

    factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id   : json["id"],
        tipo : json["tipo"],
        valor: json["valor"],
    );

    Map<String, dynamic> toJson() => {
        "id"   : id,
        "tipo" : tipo,
        "valor": valor,
    };
}
