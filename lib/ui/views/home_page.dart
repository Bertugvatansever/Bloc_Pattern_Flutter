import 'package:bertug_vatansever/app_colors.dart';
import 'package:bertug_vatansever/ui/cubit/favorite_cubit.dart';
import 'package:bertug_vatansever/ui/views/box_detail_page.dart';
import 'package:bertug_vatansever/ui/views/favorite_page.dart';

import 'package:bertug_vatansever/widgets/foods_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/food_cubit.dart';
import '../../data/entity/food.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        centerTitle: true,
        title: Text(
          "Yemek Uygulaması",
          style: TextStyle(color: AppColor.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite, color: AppColor.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FavoritesPage()),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<FoodCubit, List<Food>>(
        builder: (context, foodList) {
          if (foodList.isEmpty) {
            return SizedBox(
              width: width,
              height: height,
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColor.primaryColor,
                ),
              ),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.30,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 10,
                ),
                itemCount: foodList.length,
                itemBuilder: (context, index) {
                  return BlocBuilder<FavoriteCubit, List<Food>>(
                    builder: (context, favoriteFoods) {
                      bool isFavorite = favoriteFoods.any((favoriteFood) =>
                          favoriteFood.foodId == foodList[index].foodId);
                      return Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BoxDetailPage(
                                    food: foodList[index],
                                  ),
                                ),
                              );
                            },
                            child: FoodWidget().foodListWidget(foodList[index]),
                          ),
                          Positioned(
                            top: 5,
                            right: 5,
                            child: IconButton(
                              icon: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isFavorite ? Colors.red : Colors.grey,
                              ),
                              onPressed: () {
                                context
                                    .read<FavoriteCubit>()
                                    .toggleFavorite(foodList[index]);
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
