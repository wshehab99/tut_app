// ignore: depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezed_data_classes.freezed.dart';

@freezed
class LoginObject with _$LoginObject {
  factory LoginObject(String username, String password) = _LoginObject;
}

class RegisterObject {
  String username, password, email, phone, profileImage;
  RegisterObject(
      this.username, this.email, this.password, this.phone, this.profileImage);
  RegisterObject copyWith(
      {String? username,
      String? password,
      String? email,
      String? phone,
      String? profileImage}) {
    this.username = username ?? this.username;
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.phone = phone ?? this.phone;
    this.profileImage = profileImage ?? this.profileImage;
    return this;
  }
}
