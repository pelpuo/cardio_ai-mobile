class Patient {
  String id;
  String firstName;
  String lastName;
  String email;
  String dateOfBirth;
  String gender;

  Patient({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.dateOfBirth,
    required this.gender,
  });

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email_address': email,
      'date_of_birth': dateOfBirth,
      'gender': gender,
    };
  }

  Patient.fromJson(Map<String, dynamic> json)
      : id = json["_id"],
        firstName = json["first_name"],
        lastName = json["last_name"],
        email = json["email_address"],
        gender = json["gender"],
        dateOfBirth = json["date_of_birth"];
}
