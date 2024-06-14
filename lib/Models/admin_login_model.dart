class AdminLoginModel {
  int? role;
  int? superAdmin;
  String? message;
  bool? success;
  int? clientId;
  int? userId;
  String? clientName;
  String? email;
  String? clientLogo;
  bool? resetPassword;
  String? token;

  AdminLoginModel(
      {this.role,
      this.superAdmin,
      this.message,
      this.success,
      this.clientId,
      this.clientName,
      this.userId,
      this.email,
      this.clientLogo,
      this.resetPassword,
      this.token});

  AdminLoginModel.fromJson(Map<String, dynamic> json) {
    role = json['role'];
    superAdmin = json['super_admin'];
    message = json['message'];
    success = json['success'];
    clientId = json['client_id'];
    clientName = json['client_name'];
    userId = json['user_id'];
    email = json['email'];
    clientLogo = json['clientLogo'];
    resetPassword = json['reset_password'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['role'] = role;
    data['super_admin'] = superAdmin;
    data['message'] = message;
    data['success'] = success;
    data['client_id'] = clientId;
    data['user_id'] = userId;
    data['client_name'] = clientName;
    data['email'] = email;
    data['clientLogo'] = clientLogo;
    data['reset_password'] = resetPassword;
    data['token'] = token;
    return data;
  }
}
