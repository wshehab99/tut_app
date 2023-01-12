class SliderObject {
  String title;
  String subTitle;
  String imagePath;
  SliderObject({
    required this.title,
    required this.subTitle,
    required this.imagePath,
  });
}

class SliderObjectView {
  SliderObject sliderObject;
  int currentIndex;
  int numberOfSliders;
  SliderObjectView({
    required this.sliderObject,
    required this.numberOfSliders,
    required this.currentIndex,
  });
}

class Customer {
  String? id;
  String? name;
  int? numOfNotifications;

  Customer(
    this.id,
    this.name,
    this.numOfNotifications,
  );
}

class Contacts {
  String? phone;
  String? email;
  String? link;

  Contacts(
    this.phone,
    this.email,
    this.link,
  );
}

class Authentication {
  Customer? customer;
  Contacts? contacts;
  Authentication(this.customer, this.contacts);
}

class ForgetPasswordModel {
  String message;

  ForgetPasswordModel(this.message);
}

class Services {
  int id;
  String title;
  String image;
  Services(this.id, this.title, this.image);
}

class BannerAd {
  int id;
  String title;
  String image;
  String link;
  BannerAd(this.id, this.title, this.image, this.link);
}

class Store {
  int id;
  String title;
  String image;
  Store(this.id, this.title, this.image);
}

class HomeData {
  List<Services> services;
  List<BannerAd> banners;
  List<Store> stores;
  HomeData(this.services, this.banners, this.stores);
}

class Home {
  HomeData data;
  Home(this.data);
}

class StoreDetails {
  int id;
  String title;
  String image;
  String details;
  String services;
  String about;
  StoreDetails(
      this.id, this.title, this.image, this.details, this.services, this.about);
}
