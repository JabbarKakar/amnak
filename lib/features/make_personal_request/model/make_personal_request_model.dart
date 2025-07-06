class MakePersonalRequestModel {
  MakePersonalRequestModel({
    required this.status,
    required this.messages,
    this.data,
  });

  final int? status;
  final List<String> messages;
  final Datum? data;

  factory MakePersonalRequestModel.fromJson(Map<String, dynamic> json) {
    return MakePersonalRequestModel(
      status: json["status"],
      messages: json["messages"] == null
          ? []
          : List<String>.from(json["messages"]!.map((x) => x)),
      data: json["data"] != null ? Datum.fromJson(json["data"]) : null,
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
  final int? leaveType; // Changed from String? to int?
  final DateTime? startDate;
  final DateTime? endDate;
  final String? reason;
  final String? status;
  final int? companyId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      id: json["id"],
      personId: json["person_id"],
      leaveType: json["leave_type"], // Now expects an int
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
