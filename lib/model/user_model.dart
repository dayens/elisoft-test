class UserModel {
  final String? name;

  UserModel(this.name);

  factory UserModel.fromJson(json) {
    return UserModel(json['user']['name']);
  }
}
