import 'dart:convert';
import 'dart:math';
import 'package:bertug_vatansever/data/entity/box_food.dart';
import 'package:dio/dio.dart';
import '../entity/food.dart';

class FoodRepository {
  final Dio _dio = Dio();
  final String allFoodUrl =
      "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
  final String addBoxUrl =
      "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php";
  final String getBoxUrl =
      "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php";
  final String deleteBoxFoodUrl =
      "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php";

  Future<List<Food>> fetchFoods() async {
    try {
      final response = await _dio.get(allFoodUrl);
      if (response.statusCode == 200) {
        // response.data string olarak geldiği için decode ediyoruz
        final Map<String, dynamic> data = jsonDecode(response.data);
        List<dynamic> jsonList = data["yemekler"];
        return jsonList.map((json) => Food.fromJson(json)).toList();
      } else {
        throw Exception("API Hatası: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Bağlantı hatası: $e");
    }
  }

  Future<void> addToBox(String foodName, String foodImageName, int foodPrice,
      int foodNumber, String userName) async {
    try {
      final response = await _dio.post(addBoxUrl,
          data: FormData.fromMap({
            "yemek_adi": foodName,
            "yemek_resim_adi": foodImageName,
            "yemek_fiyat": foodPrice.toString(),
            "yemek_siparis_adet": foodNumber.toString(),
            "kullanici_adi": userName
          }));
      if (response.statusCode == 200) {
        print("Ürün sepete eklendi. ${response.data}");
      } else {
        print("Ürün sepete eklenemedi. ${response.statusCode}");
      }
    } catch (e) {
      print("hata oluştu $e ");
    }
  }

  Future<List<BoxFood>> getBox(String userName) async {
    try {
      final response = await _dio.post(
        getBoxUrl,
        data: FormData.fromMap({
          "kullanici_adi": userName,
        }),
      );

      if (response.statusCode == 200) {
        var data = response.data;
        if (data is String) {
          data = jsonDecode(data);
        }
        if (data["success"] == 1) {
          List<dynamic> boxList = data["sepet_yemekler"];
          return boxList.map((json) => BoxFood.fromJson(json)).toList();
        } else {
          return [];
        }
      } else {
        print("Bir hata oluştu: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Hata: $e");
      return [];
    }
  }

  Future<bool> deleteBoxFood(int boxFoodId, String userName) async {
    try {
      final response = await _dio.post(deleteBoxFoodUrl,
          data: FormData.fromMap(
              {"sepet_yemek_id": boxFoodId, "kullanici_adi": userName}));

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("hata $e");
      return false;
    }
  }
}
