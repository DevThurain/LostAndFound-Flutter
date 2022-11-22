class ItemVO {
  String timestamp;
  final String name;
  final String description;
  final String contactInfo;
  final double lat;
  final double lon;
  final String address;
  String photoPath;
  String uuid;
  String userName;
  String userProfile;

  ItemVO(
      {this.timestamp = "",
      required this.name,
      required this.description,
      required this.contactInfo,
      required this.lat,
      required this.lon,
      required this.address,
      this.photoPath = "",
      this.uuid = "",
      this.userName = "",
      this.userProfile = "",
      });

  Map<String, dynamic> toJson() {
    return {
      "timestamp": timestamp,
      "name": name,
      "description": description,
      "contactInfo": contactInfo,
      "photoPath": photoPath,
      "address": address,
      "lat": lat,
      "lon": lon,
      "uuid": uuid,
      "userName": userName,
      "userProfile": userProfile,
    };
  }
}
