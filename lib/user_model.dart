import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? firstName;
  String? lastName;
  String? email;
  String? photo;
  String? userId;

  UserModel(
      {this.email, this.firstName, this.lastName, this.photo, this.userId});

  UserModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : firstName = doc["first_name"],
        lastName = doc["last_name"],
        email = doc["email"],
        userId = doc["user_id"],
        photo = doc["photo"];

  Map<String, dynamic> toMap() {
    return {
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "user_id": userId,
      "photo": photo,
    };
  }
}
