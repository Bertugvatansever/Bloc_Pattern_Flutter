import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/entity/food.dart';

class FavoriteCubit extends Cubit<List<Food>> {
  FavoriteCubit() : super([]) {
    loadFavorites();
  }

  void toggleFavorite(Food food) {
    // Favoriler listesinde aynı foodId'ye sahip ürün var mı kontrol ediyoruz.
    final exists = state.any((element) => element.foodId == food.foodId);
    if (exists) {
      // Eğer favorilerde varsa, listeden çıkarıyoruz.
      final updatedFavorites =
          state.where((element) => element.foodId != food.foodId).toList();
      emit(updatedFavorites);
      saveFavorites(updatedFavorites);
    } else {
      // Favorilerde yoksa, mevcut listeye ekliyoruz.
      final updatedFavorites = [...state, food];
      emit(updatedFavorites);
      saveFavorites(updatedFavorites);
    }
  }

  Future<void> saveFavorites(List<Food> favorites) async {
    final prefs = await SharedPreferences.getInstance();

    // Önce listenizi benzersiz öğelerden oluşacak şekilde filtreleyelim.
    // Aynı foodId'ye sahip ürünlerden yalnızca ilkini alıyoruz.
    final uniqueFavorites = <Food>[];
    for (final food in favorites) {
      if (!uniqueFavorites.any((element) => element.foodId == food.foodId)) {
        uniqueFavorites.add(food);
      }
    }

    // Benzersiz favorileri JSON string listesine çeviriyoruz.
    List<String> favoritesJson =
        uniqueFavorites.map((food) => json.encode(food.toJson())).toList();

    // Kaydedilen ilk öğeyi kontrol amaçlı yazdırıyoruz.
    if (favoritesJson.isNotEmpty) {
      print("deneme: " + favoritesJson[0]);
    }

    await prefs.setStringList('favorite_foods', favoritesJson);
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? favoritesJson = prefs.getStringList('favorite_foods');
    if (favoritesJson != null) {
      List<Food> favorites = favoritesJson.map((jsonStr) {
        final jsonMap = json.decode(jsonStr);
        print(jsonMap);
        return Food.fromJson(jsonMap);
      }).toList();
      emit(favorites);
    }
  }
}
