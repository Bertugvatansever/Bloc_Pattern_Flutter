import 'package:bertug_vatansever/app_colors.dart';
import 'package:bertug_vatansever/ui/cubit/root_cubit.dart';
import 'package:bertug_vatansever/ui/views/box_page.dart';
import 'package:bertug_vatansever/ui/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RootPage extends StatelessWidget {
  RootPage({super.key});

  final List<Widget> pages = [
    HomePage(),
    BoxPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RootCubit, int>(
      builder: (context, state) {
        return Scaffold(
          body: pages[state],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: AppColor.white,
            selectedItemColor: AppColor.primaryColor,
            unselectedItemColor: AppColor.black,
            currentIndex: state,
            onTap: (index) => context.read<RootCubit>().changePage(index),
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: "Anasayfa"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart), label: "Sepet"),
            ],
          ),
        );
      },
    );
  }
}
