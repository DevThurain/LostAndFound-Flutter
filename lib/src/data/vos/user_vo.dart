import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lost_and_found/src/persistence/hive_constants.dart';
part 'user_vo.g.dart';

@HiveType(typeId: HiveConstants.HIVE_TYPE_USER_DATA, adapterName: 'UserAdapter')
class UserVO {

  @HiveField(0)
  final String fullName;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String password;

  @HiveField(3)
  final String phone;

  @HiveField(4)
  String uuid = "";

  @HiveField(5)
  String token = "";

  @HiveField(6)
  String profileUrl = "";

  UserVO(this.fullName, this.email, this.password, this.phone, this.token, this.profileUrl, this.uuid);


}
