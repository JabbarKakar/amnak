class InstructionsWrapper {
  num? status;
  List<String>? messages;
  InstructionModel? data;

  InstructionsWrapper({this.status, this.messages, this.data});

  InstructionsWrapper.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messages = json['messages'].cast<String>();
    data = json['data'] != null
        ? new InstructionModel.fromJson(json['data'])
        : null;
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

class InstructionModel {
  String? companyInstructions;

  InstructionModel({this.companyInstructions});

  InstructionModel.fromJson(Map<String, dynamic> json) {
    companyInstructions = json['company_instructions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['company_instructions'] = this.companyInstructions;
    return data;
  }
}
