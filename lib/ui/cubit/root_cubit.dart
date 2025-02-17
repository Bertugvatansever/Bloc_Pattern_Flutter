import 'package:bloc/bloc.dart';

class RootCubit extends Cubit<int> {
  RootCubit() : super(0);

  void changePage(int index) {
    emit(index);
  }
}
