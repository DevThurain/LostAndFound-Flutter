import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lost_and_found/src/persistence/hive_constants.dart';
part 'user_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HiveConstants.HIVE_TYPE_USER_DATA, adapterName: 'UserAdapter')
class UserVO {
  @HiveField(0)
  final String fullName;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String phone;

  @HiveField(3)
  final String uuid;

  @HiveField(4)
  final String token;

  @HiveField(5)
  final String profileUrl;

  UserVO({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.token,
    required this.profileUrl,
    required this.uuid,
  });

  factory UserVO.fromFireStore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    var data = snapshot.data();
    return UserVO(
        fullName: data?['fullName'],
        email: data?['email'],
        phone: data?['phone'],
        token: data?['token'],
        profileUrl: data?['profileUrl'],
        uuid: data?['uuid']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'token': token,
      'profileUrl': profileUrl,
      'uuid': uuid
    };
  }

  factory UserVO.fromJson(Map<String, dynamic> json) => _$UserVOFromJson(json);

  Map<String, dynamic> toJson() => _$UserVOToJson(this);
}
