class User {
  String? id;
  String? name;
  String? position;
  String? contactNo;

  User({this.id, this.name, this.position, this.contactNo});

  User.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    position = json['Position'];
    contactNo = json['ContactNo'];
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    data['Position'] = position;
    data['ContactNo'] = contactNo;
    return data;
  }
}
