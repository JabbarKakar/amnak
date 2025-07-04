// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amnak/core/feature/data/models/login_wrapper.dart';

class UserWrapper {
  bool? success;
  List<String>? message;
  UserModel? data;

  UserWrapper({this.success, this.message, this.data});

  UserWrapper.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new UserModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }

  @override
  String toString() =>
      'UserWrapper(success: $success, message: $message, data: $data)';
}
