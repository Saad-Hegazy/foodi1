class ImageSliderModel {
  int? ImageSliderId ;
  String? ImageSliderName;
  String? ImageSliderUserType;

  ImageSliderModel(
      {
        this.ImageSliderId,
        this.ImageSliderName,
        this.ImageSliderUserType,
      });

  ImageSliderModel.fromJson(Map<String, dynamic> json) {
    ImageSliderId = json['ImageSlider_id '];
    ImageSliderName = json['ImageSlider_name'];
    ImageSliderUserType = json['ImageSlider_usertype'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ImageSlider_id'] = ImageSliderId;
    data['ImageSlider_name'] = ImageSliderName;
    data['ImageSlider_usertype'] = ImageSliderUserType;
    return data;
  }
}