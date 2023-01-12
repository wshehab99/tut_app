import 'package:tut_app/app/constants.dart';
import 'package:tut_app/data/network/error_handler.dart';

import '../response/response.dart';

abstract class LocalDataSource {
  Future<HomeResponse> getHomeData();
  Future<StoreDetailsResponse> getStoreDetails();
  Future<void> clearCache();
  Future<void> setHomeResponseToCache(HomeResponse homeResponse);
  Future<void> setStoreDetailsResponseToCache(
      StoreDetailsResponse storeDetailsResponse);
}

class LocalDataSourceImp implements LocalDataSource {
  Map<String, CachedData> cachedData = {};

  @override
  Future<HomeResponse> getHomeData() async {
    CachedData? cachedItem = cachedData[AppConstants.cachedHomeResponse];
    if (cachedItem != null && cachedItem.isValid(AppConstants.cacheTimeOut)) {
      return cachedItem.data;
    } else {
      throw ErrorHandler.handle(DataSource.cacheError);
    }
  }

  @override
  Future<void> setHomeResponseToCache(HomeResponse homeResponse) async {
    cachedData[AppConstants.cachedHomeResponse] = CachedData(homeResponse);
  }

  @override
  Future<StoreDetailsResponse> getStoreDetails() {
    CachedData? cachedItem =
        cachedData[AppConstants.cachedStoreDetailsResponse];
    if (cachedItem != null && cachedItem.isValid(AppConstants.cacheTimeOut)) {
      return cachedItem.data;
    } else {
      throw ErrorHandler.handle(DataSource.cacheError);
    }
  }

  @override
  Future<void> setStoreDetailsResponseToCache(
      StoreDetailsResponse storeDetailsResponse) async {
    cachedData[AppConstants.cachedStoreDetailsResponse] =
        CachedData(storeDetailsResponse);
  }

  @override
  Future<void> clearCache() async {
    cachedData.clear();
  }
}

class CachedData {
  dynamic data;
  int cachedTime = DateTime.now().millisecondsSinceEpoch;
  CachedData(this.data);
}

extension CachedDataExtension on CachedData {
  bool isValid(int expirationTime) {
    return DateTime.now().millisecondsSinceEpoch - cachedTime <= expirationTime;
  }
}
