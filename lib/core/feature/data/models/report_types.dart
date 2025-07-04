// ignore_for_file: public_member_api_docs, sort_constructors_first
class ReportTypesWrapper {
  int? status;
  List<String>? messages;
  List<ReportTypeModel>? data;

  ReportTypesWrapper({this.status, this.messages, this.data});

  ReportTypesWrapper.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messages = json['messages'].cast<String>();
    if (json['data'] != null) {
      data = <ReportTypeModel>[];
      json['data'].forEach((v) {
        data!.add(new ReportTypeModel.fromJson(v));
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

class ReportTypeModel {
  int? id;
  String? name;

  ReportTypeModel({this.id, this.name});

  ReportTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }

  @override
  String toString() => '$name';
}
