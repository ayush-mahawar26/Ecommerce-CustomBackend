class UserModel {
  String? token;
  String? username;
  String? email;
  String? phn;
  String? addr;
  String? type;

  UserModel(
      {required this.token,
      required this.username,
      required this.email,
      required this.phn,
      required this.addr,
      required this.type});

  UserModel.fromJson(Map<dynamic, dynamic> json) {
    token = json['token'];
    username = json['username'];
    email = json['email'];
    phn = json['phn'];
    addr = json['addr'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['username'] = username;
    data['email'] = email;
    data['phn'] = phn;
    data['addr'] = addr;
    data['type'] = type;
    return data;
  }
}
