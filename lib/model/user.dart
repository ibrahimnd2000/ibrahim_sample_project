import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String _profileImgURL;
  String _name;
  String _email;

  String get name => _name;
  String get email => _email;
  String get profileImgURL => _profileImgURL;

  User(this._profileImgURL, this._name, this._email);

  User.fromJson(Map<String, dynamic> json)
      : _profileImgURL = json['profileImgURL'] ?? "",
        _name = json['name'] ?? "",
        _email = json['email'] ?? "";

  Map<String, dynamic> toJson() => {
        'profileImgURL': _profileImgURL,
        'name': _name,
        'email': _email,
      };

  User.fromSnapshot(QueryDocumentSnapshot snapshot)
      : _profileImgURL = snapshot['profileImgURL'],
        _name = snapshot['name'],
        _email = snapshot['email'];
}
