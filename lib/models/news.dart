class News {
  int id;
  String name;
  String profilePicture;
  String content;
  String createdAt;

  News({
    this.id,
    this.name,
    this.profilePicture,
    this.content,
    this.createdAt,
  });

  News.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    profilePicture = json['profile_picture'];
    content = json['content'];
    createdAt = json['created_at'];
  }

  News.fromJsonWS(Map<String, dynamic> json) {
    name = json['user']['name'];
    profilePicture = json['user']['profile_picture'];
    content = json['message']['content'];
    createdAt = json['message']['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['content'] = this.content;
    data['created_at'] = this.createdAt;
    data['profile_picture'] = profilePicture;

    return data;
  }
}
