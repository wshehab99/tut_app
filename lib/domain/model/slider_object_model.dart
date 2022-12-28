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
