// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
part 'response.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
  factory BaseResponse.fromJson({required Map<String, dynamic> json}) =>
      _$BaseResponseFromJson(json);
  BaseResponse(this.status, this.message);
  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
}

@JsonSerializable()
class CustomerResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "numOfNotifications")
  int? numOfNotifications;
  factory CustomerResponse.fromJson({required Map<String, dynamic> json}) =>
      _$CustomerResponseFromJson(json);
  CustomerResponse(
    this.id,
    this.name,
    this.numOfNotifications,
  );
  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);
}

@JsonSerializable()
class ContactsResponse {
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "link")
  String? link;
  factory ContactsResponse.fromJson({required Map<String, dynamic> json}) =>
      _$ContactsResponseFromJson(json);
  ContactsResponse(
    this.phone,
    this.email,
    this.link,
  );
  Map<String, dynamic> toJson() => _$ContactsResponseToJson(this);
}

class AuthenticationResponse extends BaseResponse {
  @JsonKey(name: "customer")
  CustomerResponse? customer;
  @JsonKey(name: "contacts")
  ContactsResponse? contacts;
  AuthenticationResponse(this.customer, this.contacts) : super(0, '');
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}
