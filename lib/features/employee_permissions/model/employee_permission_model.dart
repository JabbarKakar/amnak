// ignore_for_file: public_member_api_docs, sort_constructors_first
class EmployeePermissionWrapper {
  int? status;
  List<String>? messages;
  List<EmployeePermissionModel>? data;

  EmployeePermissionWrapper({
    this.status,
    this.messages,
    this.data,
  });

  EmployeePermissionWrapper.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messages =
        json['messages'] != null ? List<String>.from(json['messages']) : null;
    if (json['data'] != null) {
      data = <EmployeePermissionModel>[];
      json['data'].forEach((v) {
        data!.add(EmployeePermissionModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['messages'] = messages;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EmployeePermissionModel {
  int? id;
  int? personId;
  String? personName;
  int? companyId;
  String? companyName;
  int? projectId;
  String? projectName;
  String? permissionType;
  String? dateTime;
  String? permissionImage;

  EmployeePermissionModel({
    this.id,
    this.personId,
    this.personName,
    this.companyId,
    this.companyName,
    this.projectId,
    this.projectName,
    this.permissionType,
    this.dateTime,
    this.permissionImage,
  });

  EmployeePermissionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    personId = json['person_id'];
    personName = json['person_name'];
    companyId = json['company_id'];
    companyName = json['company_name'];
    projectId = json['project_id'];
    projectName = json['project_name'];
    permissionType = json['permission_type'];
    dateTime = json['date_time'];
    permissionImage = json['permission_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['person_id'] = personId;
    data['person_name'] = personName;
    data['company_id'] = companyId;
    data['company_name'] = companyName;
    data['project_id'] = projectId;
    data['project_name'] = projectName;
    data['permission_type'] = permissionType;
    data['date_time'] = dateTime;
    data['permission_image'] = permissionImage;
    return data;
  }
}
