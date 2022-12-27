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
