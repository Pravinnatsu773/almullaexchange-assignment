import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

// Define the state for the TabCubit
@immutable
class TabState {
  final int selectedIndex;

  const TabState(this.selectedIndex);
}

// Define the Cubit for managing the selected index
class TabCubit extends Cubit<TabState> {
  TabCubit() : super(const TabState(0)); // Default to first tab (index 0)

  void changeTab(int index) {
    emit(TabState(index)); // Update the selected tab index
  }
}
