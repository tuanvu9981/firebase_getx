class Car {
  String? id;
  String? maker;
  String? licenseId;
  String? imageUrl;
  String? userId;

  Car({this.maker, this.licenseId, this.imageUrl, this.userId});

  Car.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['imageUrl'];
    licenseId = json['licenseId'];
    maker = json['maker'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imageUrl'] = imageUrl;
    data['licenseId'] = licenseId;
    data['maker'] = maker;
    data['userId'] = userId;
    data['id'] = id;
    return data;
  }
}
