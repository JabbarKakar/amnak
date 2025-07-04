// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProjectsWrapper {
  num? status;
  List<String>? messages;
  List<ProjectModel>? data;

  ProjectsWrapper({this.status, this.messages, this.data});

  ProjectsWrapper.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messages = json['messages'].cast<String>();
    if (json['data'] != null) {
      data = <ProjectModel>[];
      json['data'].forEach((v) {
        data!.add(new ProjectModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['messages'] = this.messages;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProjectModel {
  ProjectDetails? projectDetails;
  EmployeeShift? employeeShift;
  Company? company;

  ProjectModel({this.projectDetails, this.employeeShift, this.company});

  ProjectModel.fromJson(Map<String, dynamic> json) {
    projectDetails = json['project_details'] != null
        ? new ProjectDetails.fromJson(json['project_details'])
        : null;
    employeeShift = json['employee_shift'] != null
        ? new EmployeeShift.fromJson(json['employee_shift'])
        : null;
    company =
        json['company'] != null ? new Company.fromJson(json['company']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.projectDetails != null) {
      data['project_details'] = this.projectDetails!.toJson();
    }
    if (this.employeeShift != null) {
      data['employee_shift'] = this.employeeShift!.toJson();
    }
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    return data;
  }

  @override
  String toString() => '${projectDetails?.name}';
}

class ProjectDetails {
  int? id;
  String? name;
  int? membersCount;
  String? code;
  String? type;
  String? startAt;
  String? endAt;
  String? qrCode;
  String? projectImage;
  List<ZoneCoordinates>? zoneCoordinates;

  ProjectDetails(
      {this.id,
      this.name,
      this.membersCount,
      this.code,
      this.type,
      this.startAt,
      this.endAt,
      this.qrCode,
      this.projectImage,
      this.zoneCoordinates});

  ProjectDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    membersCount = json['members_count'];
    code = json['code'];
    type = json['type'];
    startAt = json['start_at'];
    endAt = json['end_at'];
    qrCode = json['qr_code'];
    projectImage = json['project_image'];
    if (json['zone_coordinates'] != null) {
      zoneCoordinates = <ZoneCoordinates>[];
      json['zone_coordinates'].forEach((v) {
        zoneCoordinates!.add(new ZoneCoordinates.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['members_count'] = this.membersCount;
    data['code'] = this.code;
    data['type'] = this.type;
    data['start_at'] = this.startAt;
    data['end_at'] = this.endAt;
    data['qr_code'] = this.qrCode;
    data['project_image'] = this.projectImage;
    if (this.zoneCoordinates != null) {
      data['zone_coordinates'] =
          this.zoneCoordinates!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ZoneCoordinates {
  double? lat;
  double? lng;

  ZoneCoordinates({this.lat, this.lng});

  ZoneCoordinates.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class EmployeeShift {
  String? startAt;
  String? endAt;

  EmployeeShift({this.startAt, this.endAt});

  EmployeeShift.fromJson(Map<String, dynamic> json) {
    startAt = json['start_at'];
    endAt = json['end_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_at'] = this.startAt;
    data['end_at'] = this.endAt;
    return data;
  }
}

class Company {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? website;
  String? address;
  String? logo;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  Company(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.website,
      this.address,
      this.logo,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    website = json['website'];
    address = json['address'];
    logo = json['logo'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['website'] = this.website;
    data['address'] = this.address;
    data['logo'] = this.logo;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
