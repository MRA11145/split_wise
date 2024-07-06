class User {
  late String _name;
  late String _id;
  late String _email;
  late String _phone;

  User(String id, String name, String email, String phone) {
    _name = name;
    _id = id;
    _phone = phone;
    _email = email;
  }

  String getName() {
    return _name;
  }

  String getId() {
    return _id;
  }

  String getPhone() {
    return _phone;
  }

  String getEmail() {
    return _email;
  }

}