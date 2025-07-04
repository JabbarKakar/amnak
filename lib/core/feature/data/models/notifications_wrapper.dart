class NotificationsWrapper {
  num? status;
  List<String>? messages;
  List<NotificationModel>? data;

  NotificationsWrapper({this.status, this.messages, this.data});

  NotificationsWrapper.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messages = json['messages'].cast<String>();
    if (json['data'] != null) {
      data = <NotificationModel>[];
      json['data'].forEach((v) {
        data!.add(new NotificationModel.fromJson(v));
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

class NotificationModel {
  int? id;
  int? personId;
  String? title;
  String? body;
  String? url;
  int? isRead;
  String? createdAt;
  String? updatedAt;
  ExtraData? extraData;

  NotificationModel(
      {this.id,
      this.personId,
      this.title,
      this.body,
      this.url,
      this.isRead,
      this.createdAt,
      this.updatedAt,
      this.extraData});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    personId = json['person_id'];
    title = json['title'];
    body = json['body'];
    url = json['url'];
    isRead = json['is_read'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    extraData = json['extra_data'] != null
        ? new ExtraData.fromJson(json['extra_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['person_id'] = this.personId;
    data['title'] = this.title;
    data['body'] = this.body;
    data['url'] = this.url;
    data['is_read'] = this.isRead;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.extraData != null) {
      data['extra_data'] = this.extraData!.toJson();
    }
    return data;
  }
}

class ExtraData {
  String? type;
  String? rejectUrl;
  String? approveUrl;
  String? contractUrl;

  ExtraData({this.type, this.rejectUrl, this.approveUrl, this.contractUrl});

  ExtraData.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    rejectUrl = json['reject_url'];
    approveUrl = json['approve_url'];
    contractUrl = json['contractUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['reject_url'] = this.rejectUrl;
    data['approve_url'] = this.approveUrl;
    data['contractUrl'] = this.contractUrl;
    return data;
  }
}
