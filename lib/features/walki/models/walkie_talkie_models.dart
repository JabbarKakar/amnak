// ignore_for_file: public_member_api_docs, sort_constructors_first

class AgoraTokenWrapper {
  int? status;
  List<String>? messages;
  AgoraTokenData? data;

  AgoraTokenWrapper({this.status, this.messages, this.data});

  AgoraTokenWrapper.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messages = json['messages']?.cast<String>();
    data = json['data'] != null ? AgoraTokenData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['messages'] = messages;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class AgoraTokenData {
  String? channelName;
  String? token;
  String? expiresAt;

  AgoraTokenData({this.channelName, this.token, this.expiresAt});

  AgoraTokenData.fromJson(Map<String, dynamic> json) {
    channelName = json['channel_name'];
    token = json['token'];
    expiresAt = json['expires_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['channel_name'] = channelName;
    data['token'] = token;
    data['expires_at'] = expiresAt;
    return data;
  }
}

class WalkieTalkieContactsWrapper {
  int? status;
  List<String>? messages;
  WalkieTalkieContactsData? data;

  WalkieTalkieContactsWrapper({this.status, this.messages, this.data});

  WalkieTalkieContactsWrapper.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messages = json['messages']?.cast<String>();
    data = json['data'] != null
        ? WalkieTalkieContactsData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['messages'] = messages;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class WalkieTalkieContactsData {
  CompanyModel? company;
  List<PersonModel>? personsIndividual;
  List<VoiceGroupModel>? voiceGroups;

  WalkieTalkieContactsData(
      {this.company, this.personsIndividual, this.voiceGroups});

  WalkieTalkieContactsData.fromJson(Map<String, dynamic> json) {
    company =
        json['company'] != null ? CompanyModel.fromJson(json['company']) : null;
    if (json['Persons_individual'] != null) {
      personsIndividual = <PersonModel>[];
      json['Persons_individual'].forEach((v) {
        personsIndividual!.add(PersonModel.fromJson(v));
      });
    }
    if (json['voice_groups'] != null) {
      voiceGroups = <VoiceGroupModel>[];
      json['voice_groups'].forEach((v) {
        voiceGroups!.add(VoiceGroupModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (company != null) {
      data['company'] = company!.toJson();
    }
    if (personsIndividual != null) {
      data['Persons_individual'] =
          personsIndividual!.map((v) => v.toJson()).toList();
    }
    if (voiceGroups != null) {
      data['voice_groups'] = voiceGroups!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CompanyModel {
  int? id;
  String? name;
  String? type;

  CompanyModel({this.id, this.name, this.type});

  CompanyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    return data;
  }
}

class PersonModel {
  int? id;
  String? name;
  String? type;

  PersonModel({this.id, this.name, this.type});

  PersonModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    return data;
  }
}

class VoiceGroupModel {
  int? id;
  String? name;

  VoiceGroupModel({this.id, this.name});

  VoiceGroupModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class WalkieTalkieMessageWrapper {
  int? status;
  List<String>? messages;
  WalkieTalkieMessageData? data;

  WalkieTalkieMessageWrapper({this.status, this.messages, this.data});

  WalkieTalkieMessageWrapper.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messages = json['messages']?.cast<String>();
    data = json['data'] != null
        ? WalkieTalkieMessageData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['messages'] = messages;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class WalkieTalkieMessageData {
  int? id;
  String? voiceGroupId;
  String? channelName;
  int? senderId;
  String? senderType;
  String? receiverId;
  String? receiverType;
  String? message;
  String? audioPath;
  String? sentAt;

  WalkieTalkieMessageData({
    this.id,
    this.voiceGroupId,
    this.channelName,
    this.senderId,
    this.senderType,
    this.receiverId,
    this.receiverType,
    this.message,
    this.audioPath,
    this.sentAt,
  });

  WalkieTalkieMessageData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    voiceGroupId = json['voice_group_id'];
    channelName = json['channel_name'];
    senderId = json['sender_id'];
    senderType = json['sender_type'];
    receiverId = json['receiver_id'];
    receiverType = json['receiver_type'];
    message = json['message'];
    audioPath = json['audio_path'];
    sentAt = json['sent_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['voice_group_id'] = voiceGroupId;
    data['channel_name'] = channelName;
    data['sender_id'] = senderId;
    data['sender_type'] = senderType;
    data['receiver_id'] = receiverId;
    data['receiver_type'] = receiverType;
    data['message'] = message;
    data['audio_path'] = audioPath;
    data['sent_at'] = sentAt;
    return data;
  }
}
