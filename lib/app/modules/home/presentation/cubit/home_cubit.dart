import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  int lastIndex = 0;
  late TabController controller;

  void onTabControllerChange() {
    if (controller.index != lastIndex) {
      lastIndex = controller.index;
      emit(HomeSetState());
      emit(HomeInitial());
    }
  }
}
