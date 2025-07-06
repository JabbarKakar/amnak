class SafetyCheckItemsModel {
  SafetyCheckItemsModel({
    required this.status,
    required this.messages,
    required this.data,
  });

  final int? status;
  final List<String> messages;
  final List<Datum> data;

  factory SafetyCheckItemsModel.fromJson(Map<String, dynamic> json){
    return SafetyCheckItemsModel(
      status: json["status"],
      messages: json["messages"] == null ? [] : List<String>.from(json["messages"]!.map((x) => x)),
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.active,
  });

  final int? id;
  final String? name;
  final int? active;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["id"],
      name: json["name"],
      active: json["active"],
    );
  }

}
