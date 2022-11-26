import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lost_and_found/src/data/vos/user_vo.dart';

part 'item_vo.g.dart';

@JsonSerializable()
class ItemVO {
  final int timestamp;
  final String name;
  final String description;
  final String contactInfo;
  final double lat;
  final double lon;
  final String address;
  final List<String> tags;
  final String photoPath;
  final UserVO user;

  ItemVO(
      {required this.timestamp,
      required this.name,
      required this.description,
      required this.contactInfo,
      required this.lat,
      required this.lon,
      required this.photoPath,
      required this.address,
      required this.tags,
      required this.user});

  factory ItemVO.fromFireStore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    var data = snapshot.data();

    return ItemVO(
        timestamp: data?['timestamp'],
        name: data?['name'],
        description: data?['description'],
        contactInfo: data?['contactInfo'],
        lat: data?['lat'],
        lon: data?['lon'],
        photoPath: data?['photoPath'],
        address: data?['address'],
        tags: data?['tags'] is Iterable ? List.from(data?['tags']) : [],
        user: UserVO.fromJson(data?['user']));
  }

  Map<String, dynamic> toFireStore() {
    return {
      'timestamp': timestamp,
      'name': name,
      'description': description,
      'contactInfo': contactInfo,
      'lat': lat,
      'lon': lon,
      'photoPath': photoPath,
      'address': address,
      'tags': tags,
      'user': user.toJson()
    };
  }

  factory ItemVO.fromJson(Map<String, dynamic> json) => _$ItemVOFromJson(json);
  Map<String, dynamic> toJson() => _$ItemVOToJson(this);
}
