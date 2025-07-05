class SafetyCheckDetailsModel {
  SafetyCheckDetailsModel({
    required this.status,
    required this.messages,
    required this.data,
  });

  final int? status;
  final List<String> messages;
  final Data? data;

  factory SafetyCheckDetailsModel.fromJson(Map<String, dynamic> json){
    return SafetyCheckDetailsModel(
      status: json["status"],
      messages: json["messages"] == null ? [] : List<String>.from(json["messages"]!.map((x) => x)),
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.projectDetails,
    required this.safetyReports,
  });

  final ProjectDetails? projectDetails;
  final SafetyReports? safetyReports;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      projectDetails: json["project_details"] == null ? null : ProjectDetails.fromJson(json["project_details"]),
      safetyReports: json["safety_reports"] == null ? null : SafetyReports.fromJson(json["safety_reports"]),
    );
  }

}

class ProjectDetails {
  ProjectDetails({
    required this.projectId,
    required this.projectName,
  });

  final int? projectId;
  final String? projectName;

  factory ProjectDetails.fromJson(Map<String, dynamic> json){
    return ProjectDetails(
      projectId: json["project_id"],
      projectName: json["project_name"],
    );
  }

}

class SafetyReports {
  SafetyReports({
    required this.id,
    required this.safetyCheckItemId,
    required this.safetyCheckItemName,
    required this.notes,
    required this.handled,
    required this.attachments,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final int? safetyCheckItemId;
  final String? safetyCheckItemName;
  final String? notes;
  final String? handled;
  final Attachments? attachments;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory SafetyReports.fromJson(Map<String, dynamic> json){
    return SafetyReports(
      id: json["id"],
      safetyCheckItemId: json["safety_check_item_id"],
      safetyCheckItemName: json["safety_check_item_name"],
      notes: json["notes"],
      handled: json["handled"],
      attachments: json["attachments"] == null ? null : Attachments.fromJson(json["attachments"]),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

}

class Attachments {
  Attachments({
    required this.path,
    required this.type,
  });

  final String? path;
  final String? type;

  factory Attachments.fromJson(Map<String, dynamic> json){
    return Attachments(
      path: json["path"],
      type: json["type"],
    );
  }

}
