// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<UserVO> {
  @override
  final int typeId = 1;

  @override
  UserVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserVO(
      fullName: fields[0] as String,
      email: fields[1] as String,
      phone: fields[2] as String,
      token: fields[4] as String,
      profileUrl: fields[5] as String,
      uuid: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserVO obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.fullName)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.phone)
      ..writeByte(3)
      ..write(obj.uuid)
      ..writeByte(4)
      ..write(obj.token)
      ..writeByte(5)
      ..write(obj.profileUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserVO _$UserVOFromJson(Map<String, dynamic> json) => UserVO(
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      token: json['token'] as String,
      profileUrl: json['profileUrl'] as String,
      uuid: json['uuid'] as String,
    );

Map<String, dynamic> _$UserVOToJson(UserVO instance) => <String, dynamic>{
      'fullName': instance.fullName,
      'email': instance.email,
      'phone': instance.phone,
      'uuid': instance.uuid,
      'token': instance.token,
      'profileUrl': instance.profileUrl,
    };
