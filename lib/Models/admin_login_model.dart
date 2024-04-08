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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['role'] = this.role;
    data['super_admin'] = this.superAdmin;
    data['message'] = this.message;
    data['success'] = this.success;
    data['client_id'] = this.clientId;
    data['user_id'] = this.userId;
    data['email'] = this.email;
    data['clientLogo'] = this.clientLogo;
    data['reset_password'] = this.resetPassword;
    data['token'] = this.token;
    return data;
  }
}
