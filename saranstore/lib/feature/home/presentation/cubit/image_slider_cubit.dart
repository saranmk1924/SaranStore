import 'package:flutter_bloc/flutter_bloc.dart';

class ImageSliderCubit extends Cubit<int> {
  ImageSliderCubit() : super(0);

  void changePage(int index) => emit(index);

  void reset() => emit(0);
}
