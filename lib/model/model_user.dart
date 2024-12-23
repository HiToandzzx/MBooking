class User {
  final int? id;
  final String username;
  final String email;
  final String? fullName;
  final String? phone;
  final String? picture;
  final bool? role;

  User({
    this.id,
    required this.username,
    required this.email,
    this.fullName,
    this.phone,
    this.picture,
    this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      fullName: json['full_name'],
      phone: json['phone'],
      picture: json['picture'],
      role: json['role'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['full_name'] = this.fullName;
    data['phone'] = this.phone;
    data['picture'] = this.picture;
    data['role'] = this.role;
    return data;
  }
}

class AuthResponse {
  final bool success;
  final String message;
  final String? token;
  final User? user;
  final Map<String, dynamic>? errors;

  AuthResponse({
    required this.success,
    required this.message,
    this.token,
    this.user,
    this.errors,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      success: json['success'],
      message: json['message'],
      token: json['token'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      errors: json['errors'],
    );
  }
}
