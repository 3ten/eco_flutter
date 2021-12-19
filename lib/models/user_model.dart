class User {
  User({this.id});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: (json['order'] ?? 0).toString(),
    );
  }

  String? id;

  Map<String, dynamic> toJson() => {
    'id': id,
  };

}
