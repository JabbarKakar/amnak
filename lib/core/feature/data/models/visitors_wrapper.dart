// ignore_for_file: public_member_api_docs, sort_constructors_first
class VisitorsWrapper {
  num? totalItems;
  num? pageNumber;
  num? pageSize;
  num? totalPages;
  bool? success;
  List<String>? message;
  List<VisitorModel>? data;

  VisitorsWrapper(
      {this.totalItems,
      this.pageNumber,
      this.pageSize,
      this.totalPages,
      this.success,
      this.message,
      this.data});

  VisitorsWrapper.fromJson(Map<String, dynamic> json) {
    totalItems = json['totalItems'];
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    totalPages = json['totalPages'];
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <VisitorModel>[];
      json['data'].forEach((v) {
        data!.add(VisitorModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalItems'] = totalItems;
    data['pageNumber'] = pageNumber;
    data['pageSize'] = pageSize;
    data['totalPages'] = totalPages;
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VisitorModel {
  num? id;
  num? personId;
  String? companyName;
  String? name;
  String? carNumber;
  String? idNumber;
  String? createdAt;
  String? updatedAt;

  VisitorModel(
      {this.id,
      this.companyName,
      this.personId,
      this.name,
      this.carNumber,
      this.idNumber,
      this.createdAt,
      this.updatedAt});

  VisitorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['company_name'];
    personId = json['person_id'];
    name = json['name'];
    carNumber = json['car_number'];
    idNumber = json['id_number'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_name'] = this.companyName;
    data['person_id'] = this.personId;
    data['name'] = this.name;
    data['car_number'] = this.carNumber;
    data['id_number'] = this.idNumber;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
