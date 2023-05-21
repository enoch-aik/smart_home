class UserReqModel {
  final String? email;
  final String? fullName;
  final String? password;
  late String? userId;

  UserReqModel(
      {this.password, this.fullName,
      required this.email,
      this.userId = ''}) {
    _email = email;
    _password = password;
    _fullName = fullName;
  }

  String? _password;
  String? _email;
  String? _fullName;

  Map<String, dynamic> toJson() => {
        'userId': userId,
        //'password': _password,
        'email': _email,
        'fullName': _fullName,
      };
}
