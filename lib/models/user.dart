class User {
  int id;
  String user;
  String password;
  String name;

  User({
    this.id,
    this.user,
    this.password,
    this.name,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    password = json['password'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = this.user;
    data['password'] = this.password;
    data['name'] = this.name;

    return data;
  }
}
