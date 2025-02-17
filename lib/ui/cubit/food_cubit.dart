import 'package:bertug_vatansever/data/entity/food.dart';
import 'package:bertug_vatansever/data/repo/food_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodCubit extends Cubit<List<Food>> {
  final FoodRepository _foodRepository;
  FoodCubit(this._foodRepository) : super([]);

  Future<void> fetchAllFoods() async {
    try {
      List<Food> foods = await _foodRepository.fetchFoods();
      emit(foods);
    } catch (e) {
      print("Hata oluştu: $e");
    }
  }

  Future<void> addToBox(Food food, String userName) async {
    try {
      await _foodRepository.addToBox(food.foodName, food.foodImageName,
          food.foodPrice, food.foodNumber!, "bertug");
    } catch (e) {
      print("hata $e");
    }
  }
}
