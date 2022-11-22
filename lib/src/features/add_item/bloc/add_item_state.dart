part of 'add_item_bloc.dart';

class AddItemState {
  ItemVO? item;
  bool isLoading;
  bool isSuccess;
  AppError? appError;

  AddItemState({this.item, this.isLoading = false, this.isSuccess = false,this.appError});
}

