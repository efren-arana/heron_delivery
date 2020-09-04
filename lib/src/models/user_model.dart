class UserModel {
  final String id;
  final String fullName;
  final String email;
  final String userRole;

  UserModel({this.id, this.fullName, this.email, this.userRole});

  UserModel.fromData(Map<String, dynamic> data)
      : id = data['user_id'],
        fullName = data['full_name'],
        email = data['email'],
        userRole = data['user_role'];

  Map<String, dynamic> toJson() {
    return {
      'user_id': id,
      'full_name': fullName,
      'email': email,
      'user_role': userRole,
    };
  }
}