class AuthUser {
  String token;
  String email;
  String role;

  AuthUser({
    required this.token,
    required this.email,
    required this.role,
  });

  factory AuthUser.fromJson(Map<String, dynamic> json) => AuthUser(
        token: json["token"],
        email: json["email"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "email": email,
        "role": role,
      };

  bool isAdmin() {
    return role == "admin";
  }
}
