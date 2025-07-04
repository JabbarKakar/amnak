// ignore_for_file: public_member_api_docs, sort_constructors_first
class ChatPersonsWrapper {
  int? status;
  List<String>? messages;
  Data? data;

  ChatPersonsWrapper({this.status, this.messages, this.data});

  ChatPersonsWrapper.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messages = json['messages'].cast<String>();
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['messages'] = this.messages;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<PersonModel>? persons;
  List<PersonModel>? companies;
  num? projectId;

  Data({
    this.persons,
    this.companies,
    this.projectId,
  });

  Data.fromJson(Map<String, dynamic> json) {
    if (json['persons'] != null) {
      persons = <PersonModel>[];
      json['persons'].forEach((v) {
        persons!.add(new PersonModel.fromJson(v));
      });
    }
    if (json['companies'] != null) {
      companies = <PersonModel>[];
      json['companies'].forEach((v) {
        companies!.add(new PersonModel.fromJson(v));
        persons!.add(new PersonModel.fromJson(v));
      });
    }
    projectId = json['project_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.persons != null) {
      data['persons'] = this.persons!.map((v) => v.toJson()).toList();
    }
    if (this.companies != null) {
      data['companies'] = this.companies!.map((v) => v.toJson()).toList();
    }
    data['project_id'] = this.projectId;
    return data;
  }
}

class PersonModel {
  int? id;
  String? type;
  String? personFirstName;
  String? personLastName;
  String? name;

  PersonModel({this.id, this.type, this.personFirstName, this.personLastName});

  PersonModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    personFirstName = json['person_first_name'];
    personLastName = json['person_last_name'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['person_first_name'] = this.personFirstName;
    data['person_last_name'] = this.personLastName;
    data['name'] = this.name;
    return data;
  }
}
