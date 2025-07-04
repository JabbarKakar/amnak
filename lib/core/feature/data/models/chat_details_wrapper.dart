class ChatDetailsWrapper {
  int? status;
  List<String>? messages;
  List<MessageModel>? data;

  ChatDetailsWrapper({this.status, this.messages, this.data});

  ChatDetailsWrapper.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messages = json['messages'].cast<String>();
    if (json['data'] != null) {
      data = <MessageModel>[];
      json['data'].forEach((v) {
        data!.add(new MessageModel.fromJson(v));
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

class MessageModel {
  int? id;
  int? senderId;
  String? senderType;
  int? recipientId;
  String? recipientType;
  String? content;
  int? isRead;
  String? createdAt;
  String? updatedAt;
  List<String>? attachments;

  MessageModel(
      {this.id,
      this.senderId,
      this.senderType,
      this.recipientId,
      this.recipientType,
      this.content,
      this.isRead,
      this.createdAt,
      this.updatedAt,
      this.attachments});

  MessageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['sender_id'];
    senderType = json['sender_type'];
    recipientId = json['recipient_id'];
    recipientType = json['recipient_type'];
    content = json['content'];
    isRead = json['is_read'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['attachments'] != null) {
      attachments = <String>[];
      json['attachments'].forEach((v) {
        // attachments!.add(new Null.fromJson(v));
        attachments!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sender_id'] = this.senderId;
    data['sender_type'] = this.senderType;
    data['recipient_id'] = this.recipientId;
    data['recipient_type'] = this.recipientType;
    data['content'] = this.content;
    data['is_read'] = this.isRead;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.attachments != null) {
      data['attachments'] = this.attachments!;
    }
    return data;
  }
}
