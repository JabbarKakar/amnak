class SafetyCheckProjectDetailsModel {
  SafetyCheckProjectDetailsModel({
    required this.status,
    required this.messages,
    required this.data,
  });

  final int? status;
  final List<String> messages;
  final Data? data;

  factory SafetyCheckProjectDetailsModel.fromJson(Map<String, dynamic> json){
    return SafetyCheckProjectDetailsModel(
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
  final List<SafetyReport> safetyReports;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      projectDetails: json["project_details"] == null ? null : ProjectDetails.fromJson(json["project_details"]),
      safetyReports: json["safety_reports"] == null ? [] : List<SafetyReport>.from(json["safety_reports"]!.map((x) => SafetyReport.fromJson(x))),
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

class SafetyReport {
  SafetyReport({
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

  factory SafetyReport.fromJson(Map<String, dynamic> json){
    return SafetyReport(
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
