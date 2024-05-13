class AdminLoginModel {
  int? role;
  int? superAdmin;
  String? message;
  bool? success;
  int? clientId;
  int? userId;
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
    userId = json['user_id'];
    email = json['email'];
    clientLogo = json['clientLogo'];
    resetPassword = json['reset_password'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['role'] = role;
    data['super_admin'] = superAdmin;
    data['message'] =message;
    data['success'] = success;
    data['client_id'] = clientId;
    data['user_id'] = userId;
    data['email'] = email;
    data['clientLogo'] = clientLogo;
    data['reset_password'] = resetPassword;
    data['token'] = token;
    return data;
  }
}
