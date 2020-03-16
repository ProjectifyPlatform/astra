class User {
  final String email;
  final String name;
  final String username;
  final String joinedDate;
  final int roleId;

  User({
    this.email,
    this.name,
    this.username,
    this.joinedDate,
    this.roleId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json["email"],
      name: json["name"],
      username: json["username"],
      joinedDate: json["joined_date"],
      roleId: json["role_id"],
    );
  }
}
