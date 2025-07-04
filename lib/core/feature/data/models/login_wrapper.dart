class LoginWrapper {
  int? status;
  List<String>? messages;
  UserModel? data;

  LoginWrapper({this.status, this.messages, this.data});

  LoginWrapper.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messages = json['messages'].cast<String>();
    data = json['data'] != null ? UserModel.fromJson(json['data']) : null;
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

class UserModel {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? gender;
  String? dateOfBirth;
  String? nationalId;
  int? height;
  int? weight;
  String? qualificationsDescriptions;
  String? salary;
  String? jobNumber;
  String? companyId;
  String? companyName;
  String? latitude;
  String? longitude;
  String? token;
  String? typeAccount;
  String? deviceToken;
  String? deviceType;
  String? idImage;
  String? profileImage;
  List<CourseQualificationImages>? courseQualificationImages;
  String? noExperienceYears;

  UserModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.gender,
      this.dateOfBirth,
      this.nationalId,
      this.height,
      this.weight,
      this.qualificationsDescriptions,
      this.salary,
      this.typeAccount,
      this.jobNumber,
      this.companyId,
      this.companyName,
      this.latitude,
      this.longitude,
      this.token,
      this.deviceToken,
      this.deviceType,
      this.idImage,
      this.profileImage,
      this.courseQualificationImages,
      this.noExperienceYears});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    gender = json['gender'];
    dateOfBirth = json['date_of_birth'];
    nationalId = json['national_id'];
    height = json['height'];
    weight = json['weight'];
    qualificationsDescriptions = json['qualifications_descriptions'];
    salary = json['salary'];
    jobNumber = json['job_number'];
    companyId = json['company_id'].toString();
    companyName = json['company_name'];
    latitude = json['latitude'];
    typeAccount = json['type_account'];
    longitude = json['longitude'];
    token = json['token'];
    deviceToken = json['device_token'];
    deviceType = json['device_type'];
    idImage = json['id_image'];
    profileImage = json['profile_image'];
    if (json['course_qualification_images'] != null) {
      courseQualificationImages = <CourseQualificationImages>[];
      json['course_qualification_images'].forEach((v) {
        courseQualificationImages!
            .add(new CourseQualificationImages.fromJson(v));
      });
    }
    noExperienceYears = json['no_experience_years'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['gender'] = this.gender;
    data['date_of_birth'] = this.dateOfBirth;
    data['type_account'] = this.typeAccount;
    data['national_id'] = this.nationalId;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['qualifications_descriptions'] = this.qualificationsDescriptions;
    data['salary'] = this.salary;
    data['job_number'] = this.jobNumber;
    data['company_id'] = this.companyId;
    data['company_name'] = this.companyName;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['token'] = this.token;
    data['device_token'] = this.deviceToken;
    data['device_type'] = this.deviceType;
    data['id_image'] = this.idImage;
    data['profile_image'] = this.profileImage;
    if (this.courseQualificationImages != null) {
      data['course_qualification_images'] =
          this.courseQualificationImages!.map((v) => v.toJson()).toList();
    }
    data['no_experience_years'] = this.noExperienceYears;
    return data;
  }
}

class CourseQualificationImages {
  String? path;
  String? type;

  CourseQualificationImages({this.path, this.type});

  CourseQualificationImages.fromJson(Map<String, dynamic> json) {
    path = json['path'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['path'] = path;
    data['type'] = type;
    return data;
  }
}
