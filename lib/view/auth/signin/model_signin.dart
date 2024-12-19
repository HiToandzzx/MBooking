class User {
  final int id;
  final String username;
  final String email;
  final String fullName;
  final String phone;
  final String picture;
  final int role;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.fullName,
    required this.phone,
    required this.picture,
    required this.role,
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
    return {
      'id': id,
      'username': username,
      'email': email,
      'full_name': fullName,
      'phone': phone,
      'picture': picture,
      'role': role,
    };
  }
}