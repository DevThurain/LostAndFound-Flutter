part of 'home_bloc.dart';

@immutable
class HomeState {
  bool isLoading;
  bool isSuccess;
  AppError? appError;
  List<TagVO> tagList;
  List<ItemVO> itemList;

  HomeState(
      {this.tagList = const [],
      this.itemList = const [],
      this.isLoading = false,
      this.isSuccess = false,
      this.appError
      });
}
