part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class EventGetHomeData extends HomeEvent {
  // int page;
  // int max;

  // EventGetHomeData({required this.page, required this.max});
}

class EventGetHomeFirstData extends HomeEvent {}

class EventGetHomeNextData extends HomeEvent {}
