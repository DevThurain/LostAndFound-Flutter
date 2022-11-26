part of 'add_item_bloc.dart';

abstract class AddItemEvent {}

class EventOnAddItem extends AddItemEvent {
  final String name;
  final String description;
  final String conteacInfo;
  final double lat;
  final double lon;
  final String address;
  final String photoPath;
  final List<String> tags;
  EventOnAddItem({
    required this.name,
    required this.description,
    required this.conteacInfo,
    required this.lat,
    required this.lon,
    required this.address,
    required this.photoPath,
     required this.tags
  });
}
