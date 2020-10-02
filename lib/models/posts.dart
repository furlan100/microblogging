class Posts {
  int id;
  String name;
  String content;
  String createdAt;

  Posts({
    this.id,
    this.name,
    this.content,
    this.createdAt,
  });

  Posts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    content = json['content'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['content'] = this.content;
    data['created_at'] = this.createdAt;

    return data;
  }
}
