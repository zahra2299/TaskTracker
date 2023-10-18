class UserModel {
  String id;
  String email;
  String name;
  int age;

  UserModel(
      {required this.id,
      required this.email,
      required this.name,
      required this.age});

  UserModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json["id"],
          email: json["email"],
          name: json["name"],
          age: json["age"],
        );

  Map<String, dynamic> toJson() {
    return {"id": id, "email": email, "name": name, "age": age};
  }
}
