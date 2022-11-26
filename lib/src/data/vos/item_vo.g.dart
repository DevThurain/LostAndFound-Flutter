// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemVO _$ItemVOFromJson(Map<String, dynamic> json) => ItemVO(
      timestamp: json['timestamp'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      contactInfo: json['contactInfo'] as String,
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      photoPath: json['photoPath'] as String,
      address: json['address'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      user: UserVO.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ItemVOToJson(ItemVO instance) => <String, dynamic>{
      'timestamp': instance.timestamp,
      'name': instance.name,
      'description': instance.description,
      'contactInfo': instance.contactInfo,
      'lat': instance.lat,
      'lon': instance.lon,
      'address': instance.address,
      'tags': instance.tags,
      'photoPath': instance.photoPath,
      'user': instance.user,
    };
