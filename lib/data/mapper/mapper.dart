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

extension ServiceResponseMapper on ServicesResponse {
  Services toDomain() =>
      Services(id.orZero(), title.orEmpty(), image.orEmpty());
}

extension BanaresResponseMapper on BanaresResponse {
  BannerAd toDomain() =>
      BannerAd(id.orZero(), title.orEmpty(), image.orEmpty(), link.orEmpty());
}

extension StoresResponseMapper on StoresResponse {
  Store toDomain() => Store(id.orZero(), title.orEmpty(), image.orEmpty());
}

extension HomeResponseMapper on HomeResponse? {
  Home toDomain() {
    final List<Services> services =
        this?.data?.services.map((element) => element.toDomain()).toList() ??
            const Iterable.empty().cast<Services>().toList();
    final List<BannerAd> banares =
        this?.data?.banares.map((element) => element.toDomain()).toList() ??
            const Iterable.empty().cast<BannerAd>().toList();
    final List<Store> stores =
        this?.data?.stores.map((element) => element.toDomain()).toList() ??
            const Iterable.empty().cast<Store>().toList();
    final HomeData data = HomeData(services, banares, stores);
    return Home(data);
  }
}

extension StoreDetailsResponseMapper on StoreDetailsResponse {
  StoreDetails toDomain() => StoreDetails(id.orZero(), title.orEmpty(),
      image.orEmpty(), details.orEmpty(), services.orEmpty(), about.orEmpty());
}
