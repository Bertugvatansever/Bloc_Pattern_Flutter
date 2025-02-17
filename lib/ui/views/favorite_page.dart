import 'package:bertug_vatansever/ui/cubit/favorite_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/entity/food.dart';
import 'package:bertug_vatansever/app_colors.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Favori Yemekler",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<FavoriteCubit, List<Food>>(
        builder: (context, favoriteFoods) {
          if (favoriteFoods.isEmpty) {
            return const Center(
              child: Text(
                "Henüz favori eklenmemiş.",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(10.0), // Kenarlardan boşluk bırak
            child: ListView.builder(
              itemCount: favoriteFoods.length,
              itemBuilder: (context, index) {
                var food = favoriteFoods[index];
                return Card(
                  elevation: 6, // Gölgeyi artırdım
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(15), // Köşeleri yuvarlat
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      leading: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(12), // Resmi yuvarlat
                        child: Image.network(
                          "http://kasimadalan.pe.hu/yemekler/resimler/${food.foodImageName}",
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        food.foodName,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        "${food.foodPrice} ₺",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColor.primaryColor),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          context.read<FavoriteCubit>().toggleFavorite(food);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
