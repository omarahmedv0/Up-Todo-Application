// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class LoginModel extends Equatable {
  int id;
  String username;
  String email;
  String token;
  String refreshToken;
  String gender;
  String image;
  String firstName;
  String lastName;

  LoginModel({
    required this.id,
    required this.username,
    required this.email,
    required this.token,
    required this.refreshToken,
    required this.gender,
    required this.image,
    required this.firstName,
    required this.lastName,
  });
  
  @override
  List<Object?> get props => [
    id,
    username,
    email,
    token,
    refreshToken,
    gender,
    image,
    firstName,
    lastName
  ];
}
