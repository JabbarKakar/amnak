class PersonalRequestModel {
  PersonalRequestModel({
    required this.status,
    required this.messages,
    required this.data,
  });

  final int? status;
  final List<String> messages;
  final List<Datum> data;

  factory PersonalRequestModel.fromJson(Map<String, dynamic> json){
    return PersonalRequestModel(
      status: json["status"],
      messages: json["messages"] == null ? [] : List<String>.from(json["messages"]!.map((x) => x)),
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

}

class Datum {
  Datum({
    required this.id,
    required this.personId,
    required this.leaveType,
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.status,
    required this.companyId,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final int? personId;
  final String? leaveType;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? reason;
  final String? status;
  final int? companyId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["id"],
      personId: json["person_id"],
      leaveType: json["leave_type"],
      startDate: DateTime.tryParse(json["start_date"] ?? ""),
      endDate: DateTime.tryParse(json["end_date"] ?? ""),
      reason: json["reason"],
      status: json["status"],
      companyId: json["company_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

}
