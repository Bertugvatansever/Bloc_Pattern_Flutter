import 'package:bertug_vatansever/data/entity/box_food.dart';
import 'package:bertug_vatansever/data/entity/food.dart';
import 'package:bertug_vatansever/data/repo/food_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BoxCubit extends Cubit<List<BoxFood>> {
  final FoodRepository _foodRepository;
  bool isLoading = false;
  BoxCubit(this._foodRepository) : super([]);

  Future<void> fetchBoxFoods({required String userName}) async {
    isLoading = true;
    emit([]); // UI'ya yükleniyor sinyali verebilmek için boş liste
    try {
      List<BoxFood> boxFoods = await _foodRepository.getBox(userName);
      for (var element in boxFoods) {
        element.totalPrice = element.foodNumber! * element.foodPrice;
      }
      isLoading = false;
      emit(List.from(boxFoods));
    } catch (e) {
      print("Sepeti getirirken hata oluştu: $e");
      isLoading = false;
      emit([]);
    }
  }

  Future<bool> deleteBoxFood(int boxFoodId, String userName) async {
    bool process = await _foodRepository.deleteBoxFood(boxFoodId, userName);
    if (process) {
      final updatedList =
          state.where((boxFood) => boxFood.foodId != boxFoodId).toList();
      emit(updatedList);
    }
    return process;
  }
}
