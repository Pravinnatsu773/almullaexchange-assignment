import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
class TabState {
  final int selectedIndex;

  const TabState(this.selectedIndex);
}

class TabCubit extends Cubit<TabState> {
  TabCubit() : super(const TabState(0));

  void changeTab(int index) {
    emit(TabState(index));
  }
}
