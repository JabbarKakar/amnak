class LecturesWrapper {
  int? status;
  List<String>? messages;
  List<Data>? data;

  LecturesWrapper({this.status, this.messages, this.data});

  LecturesWrapper.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messages = json['messages'].cast<String>();
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  int? id;
  int? courseId;
  String? courseTitle;
  String? title;
  String? description;
  String? videoUrl;
  String? pdfUrl;
  Null? startDate;
  Null? endDate;
  bool? active;

  Data(
      {this.id,
      this.courseId,
      this.courseTitle,
      this.title,
      this.description,
      this.videoUrl,
      this.pdfUrl,
      this.startDate,
      this.endDate,
      this.active});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['course_id'];
    courseTitle = json['course_title'];
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
    data['course_id'] = this.courseId;
    data['course_title'] = this.courseTitle;
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
