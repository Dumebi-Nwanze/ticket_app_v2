class UserModel {
  final String uid;
  final String firstname;
  final String lastname;
  final String email;

  const UserModel({
    required this.uid,
    required this.email,
    required this.firstname,
    required this.lastname,
  });
  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "firstname": firstname,
      "lastname": lastname,
      "email": email,
    };
  }
}
