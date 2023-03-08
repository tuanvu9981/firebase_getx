class FSUser {
  // FSUser = FireStore User
  String? uid;
  String? imageUrl;
  String? email;
  String? fullname;

  FSUser({this.uid, this.imageUrl, this.email, this.fullname});

  FSUser.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    imageUrl = json['imageUrl'];
    email = json['email'];
    fullname = json['fullname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['imageUrl'] = imageUrl;
    data['email'] = email;
    data['fullname'] = fullname;
    return data;
  }
}
