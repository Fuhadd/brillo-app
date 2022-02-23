//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String userName;
  final String gender;
  final String phone;

  final String email;
  final List<dynamic> interests;
  final String imageUrl;

  User({
    required this.userName,
    required this.email,
    required this.phone,
    required this.gender,
    required this.interests,
    required this.imageUrl,
  });

  // Map<String, dynamic> toJson() {
  //   return {
  //     'uid': uid,
  //     'userName': name,
  //     'age': age,
  //     'gender': gender,
  //     'bio': bio,
  //     'country': country,
  //     // 'state': state,
  //     // 'imageUrl': imageUrl,
  //   };
  // }

  static User fromJson(json) => User(
      phone: json['phone'],
      email: json['email'],
      userName: json['userName'],
      gender: json['gender'],
      interests: json['interests'],
      imageUrl: json['imageUrl']);
}
