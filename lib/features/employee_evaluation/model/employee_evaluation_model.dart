// ignore_for_file: public_member_api_docs, sort_constructors_first
class EmployeeEvaluationWrapper {
  int? status;
  List<String>? messages;
  List<EmployeeEvaluationModel>? data;

  EmployeeEvaluationWrapper({
    this.status,
    this.messages,
    this.data,
  });

  EmployeeEvaluationWrapper.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messages =
        json['messages'] != null ? List<String>.from(json['messages']) : null;
    if (json['data'] != null) {
      data = <EmployeeEvaluationModel>[];
      json['data'].forEach((v) {
        data!.add(EmployeeEvaluationModel.fromJson(v));
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

class EmployeeEvaluationModel {
  int? id;
  int? personId;
  String? personName;
  int? companyId;
  String? companyName;
  String? evaluationTitle;
  int? totalScore;
  double? averageScore;
  List<EvaluationDetailModel>? details;
  String? createdAt;

  EmployeeEvaluationModel({
    this.id,
    this.personId,
    this.personName,
    this.companyId,
    this.companyName,
    this.evaluationTitle,
    this.totalScore,
    this.averageScore,
    this.details,
    this.createdAt,
  });

  EmployeeEvaluationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    personId = json['person_id'];
    personName = json['person_name'];
    companyId = json['company_id'];
    companyName = json['company_name'];
    evaluationTitle = json['evaluation_title'];
    totalScore = json['total_score'];
    averageScore = json['average_score']?.toDouble();
    if (json['details'] != null) {
      details = <EvaluationDetailModel>[];
      json['details'].forEach((v) {
        details!.add(EvaluationDetailModel.fromJson(v));
      });
    }
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['person_id'] = personId;
    data['person_name'] = personName;
    data['company_id'] = companyId;
    data['company_name'] = companyName;
    data['evaluation_title'] = evaluationTitle;
    data['total_score'] = totalScore;
    data['average_score'] = averageScore;
    if (details != null) {
      data['details'] = details!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = createdAt;
    return data;
  }
}

class EvaluationDetailModel {
  int? id;
  String? evaluationItem;
  int? score;
  String? createdAt;

  EvaluationDetailModel({
    this.id,
    this.evaluationItem,
    this.score,
    this.createdAt,
  });

  EvaluationDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    evaluationItem = json['evaluation_item'];
    score = json['score'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['evaluation_item'] = evaluationItem;
    data['score'] = score;
    data['created_at'] = createdAt;
    return data;
  }
}
