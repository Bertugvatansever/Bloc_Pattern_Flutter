import 'package:bertug_vatansever/ui/cubit/box_cubit.dart';
import 'package:bertug_vatansever/ui/cubit/favorite_cubit.dart';
import 'package:bertug_vatansever/ui/cubit/food_cubit.dart';
import 'package:bertug_vatansever/ui/cubit/root_cubit.dart';
import 'package:bertug_vatansever/ui/views/root_page.dart';
import 'package:bertug_vatansever/data/repo/food_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final foodRepository = FoodRepository(); // FoodRepository örneği oluştur

  runApp(MainApp(foodRepository: foodRepository));
}

class MainApp extends StatelessWidget {
  final FoodRepository foodRepository;

  const MainApp({super.key, required this.foodRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => RootCubit()), // RootCubit burada tanımlandı
        BlocProvider(
            create: (context) => FoodCubit(foodRepository)..fetchAllFoods()),
        BlocProvider(
            create: (context) =>
                BoxCubit(foodRepository)..fetchBoxFoods(userName: "bertug")),
        BlocProvider(create: (context) => FavoriteCubit())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: RootPage(),
      ),
    );
  }
}
