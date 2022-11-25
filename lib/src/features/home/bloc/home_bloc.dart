import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:lost_and_found/src/core/constants/app_constants.dart';
import 'package:lost_and_found/src/data/models/lost_and_found_model_impl.dart';
import 'package:lost_and_found/src/data/vos/app_error.dart';
import 'package:lost_and_found/src/data/vos/item_vo.dart';
import 'package:lost_and_found/src/data/vos/tag_vo.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final LostAndFoundModelImpl _lostAndFoundModelImpl = LostAndFoundModelImpl();
  List<ItemVO> mItemList = [];
  List<TagVO> mTagList = [];
  List<DocumentSnapshot> mDocumentList = [];
  TagVO? selectedTag;
  int limit = 3;
  bool reachEnd = false;

  HomeBloc() : super(HomeState()) {
    on<HomeEvent>((event, emit) async {
      if (event is EventGetHomeFirstData) {
        AppConstants.tagList.forEach((element) {
          mTagList.add(TagVO(name: element));
        });
        reachEnd = false;
        var eventGetHomeData = event;
        emit(HomeState(isLoading: true));

        var registerEvent = event;
        Either<AppError, Map<String, dynamic>> fetchResponse =
            await _lostAndFoundModelImpl.fetchFirstItems(limit);

        fetchResponse.fold((left) {
          emit(HomeState(appError: left));
        }, (right) {
          mDocumentList = right['documents'] as List<DocumentSnapshot>;
          var rightList = right['items'] as List<ItemVO>;
          mItemList = rightList;

          emit(HomeState(itemList: mItemList, tagList: mTagList, isSuccess: true));
        });
      } else if (event is EventGetHomeNextData) {
        var eventGetHomeData = event;

        var registerEvent = event;
        Either<AppError, Map<String, dynamic>> fetchResponse =
            await _lostAndFoundModelImpl.fetchNextItems(mDocumentList, limit);

        fetchResponse.fold((left) {
          emit(HomeState(appError: left));
        }, (right) {
          mDocumentList = right['documents'] as List<DocumentSnapshot>? ?? [];
          var rightList = right['items'] as List<ItemVO>? ?? [];
          mItemList.addAll(rightList);
          if (rightList.length < limit) {
            reachEnd = true;
          }

          emit(HomeState(itemList: mItemList, tagList: mTagList, isSuccess: true));
        });
      }
    });
  }
}
