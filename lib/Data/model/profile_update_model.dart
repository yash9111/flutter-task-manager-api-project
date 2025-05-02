class ProfileUpdateModel {
  String? email;
  String? firstName;
  String? lastName;
  String? mobile;
  String? password;

  ProfileUpdateModel(
      {this.email, this.firstName, this.lastName, this.mobile, this.password});

  ProfileUpdateModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    mobile = json['mobile'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = this.email;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['mobile'] = this.mobile;
    data['password'] = this.password;
    return data;
  }
}