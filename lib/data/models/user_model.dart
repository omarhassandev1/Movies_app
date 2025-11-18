class UserModel {
  final String id;
  final String name;
  final String email;
  final String cellphone;
  final int avaterId;
  final String? token;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.cellphone,
    required this.avaterId,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id']?.toString() ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      cellphone: json['phone'] ?? '',
      avaterId: json['avaterId'] ?? 1,
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": cellphone,
    "avaterId": avaterId,
    "token": token,
  };
}
