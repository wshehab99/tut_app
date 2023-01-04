import 'package:tut_app/app/constants.dart';
import 'package:tut_app/app/extension.dart';
import 'package:tut_app/domain/model/slider_object_model.dart';

import '../response/response.dart';

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
        this?.id ?? AppConstants.empty,
        this?.name ?? AppConstants.empty,
        this?.numOfNotifications ?? AppConstants.zero);
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(this?.email ?? AppConstants.empty,
        this?.phone ?? AppConstants.empty, this?.link ?? AppConstants.empty);
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
      this?.customer.toDomain(),
      this?.contacts.toDomain(),
    );
  }
}

extension ForgetPasswordResponseMapper on ForgetPasswordResponse? {
  ForgetPasswordModel toDomain() {
    return ForgetPasswordModel(
      this?.message.orEmpty() ?? "",
    );
  }
}
