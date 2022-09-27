class User {
  String id;
  String firstName;
  String lastName;
  String email;
  String role;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
  });

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email_address': email,
      'role': role,
    };
  }

  User.fromJson(Map<String, dynamic> json)
      : id = json["_id"],
        firstName = json["first_name"],
        lastName = json["last_name"],
        email = json["email_address"],
        role = json["role"];
}
