//Model for User, this includes email, full name, password and user Id

class UserReqModel {
  final String? email;
  final String? fullName;
  final String? password;
  late String? userId;

  UserReqModel(
      {this.password, this.fullName, required this.email, this.userId = ''}) {
    _email = email;
    _fullName = fullName;
  }

  String? _email;
  String? _fullName;

  //Converts User class to json
  Map<String, dynamic> toJson() => {
        'userId': userId,
        'email': _email,
        'fullName': _fullName,
      };
}
