import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:lost_and_found/src/data/models/lost_and_found_model_impl.dart';
import 'package:lost_and_found/src/data/vos/app_error.dart';
import 'package:lost_and_found/src/data/vos/item_vo.dart';
import 'package:lost_and_found/src/data/vos/user_vo.dart';
import 'package:meta/meta.dart';

part 'add_item_event.dart';
part 'add_item_state.dart';

class AddItemBloc extends Bloc<AddItemEvent, AddItemState> {
  final LostAndFoundModelImpl _lostAndFoundModelImpl = LostAndFoundModelImpl();

  AddItemBloc() : super(AddItemState()) {
    on<AddItemEvent>((event, emit) async {
      if (event is EventOnAddItem) {
        emit(AddItemState(isLoading: true));

        var uploadEvent = event;
        Either<AppError, ItemVO> uploadResponse =
            await _lostAndFoundModelImpl.uploadItem(
              uploadEvent.name,
              uploadEvent.description,
              uploadEvent.conteacInfo,
              uploadEvent.lat,
              uploadEvent.lon,
              uploadEvent.address,
              uploadEvent.photoPath,
              uploadEvent.tags
            );

        uploadResponse.fold((left) {
          emit(AddItemState(appError: left));
        }, (right) {
          emit(AddItemState(item: right, isSuccess: true));
        });
      }
    });
  }
}
