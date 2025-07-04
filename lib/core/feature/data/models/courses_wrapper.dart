class CoursesWrapper {
  int? status;
  List<String>? messages;
  List<CourseModel>? data;

  CoursesWrapper({this.status, this.messages, this.data});

  CoursesWrapper.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messages = json['messages'].cast<String>();
    if (json['data'] != null) {
      data = <CourseModel>[];
      json['data'].forEach((v) {
        data!.add(new CourseModel.fromJson(v));
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

class CourseModel {
  int? id;
  String? title;
  String? description;
  String? videoUrl;
  String? pdfUrl;
  String? startDate;
  String? endDate;
  bool? active;

  CourseModel(
      {this.id,
      this.title,
      this.description,
      this.videoUrl,
      this.pdfUrl,
      this.startDate,
      this.endDate,
      this.active});

  CourseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    videoUrl = json['video_url'];
    pdfUrl = json['pdf_url'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['video_url'] = this.videoUrl;
    data['pdf_url'] = this.pdfUrl;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['active'] = this.active;
    return data;
  }
}
