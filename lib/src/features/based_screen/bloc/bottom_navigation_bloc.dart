import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bottom_navigation_event.dart';
part 'bottom_navigation_state.dart';

class BottomNavigationBloc extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  BottomNavigationBloc() : super(BottomNavigationState(0)) {
    on<BottomNavigationEvent>((event, emit) {
      if (event is EventBottomNavigationChange) {
        var changeEvent = event as EventBottomNavigationChange;
        emit(BottomNavigationState(changeEvent.position));
      }
    });
  }
}
