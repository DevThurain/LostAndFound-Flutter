part of 'add_item_bloc.dart';

abstract class AddItemEvent {}

class EventOnAddItem extends AddItemEvent {
  final ItemVO item;
  EventOnAddItem(this.item);
}
