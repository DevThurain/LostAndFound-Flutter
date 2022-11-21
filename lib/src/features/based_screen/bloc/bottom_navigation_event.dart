part of 'bottom_navigation_bloc.dart';

@immutable
abstract class BottomNavigationEvent {}


 class EventBottomNavigationChange extends BottomNavigationEvent {
    late final int position;
    EventBottomNavigationChange(this.position);
}
