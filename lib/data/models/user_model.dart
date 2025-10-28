class UserModel {
  final String id;
  final String name;
  final String email;
  final String cellphone;
  final int avatarNo;
  final String? token;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.cellphone,
    required this.avatarNo,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id']?.toString() ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      cellphone: json['cellphone'] ?? '',
      avatarNo: json['avatarNo'] ?? 1,
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "cellphone": cellphone,
    "avatarNo": avatarNo,
    "token": token,
  };
}
