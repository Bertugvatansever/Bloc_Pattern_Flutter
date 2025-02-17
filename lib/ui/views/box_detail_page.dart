import 'package:bertug_vatansever/app_colors.dart';
import 'package:bertug_vatansever/data/entity/food.dart';
import 'package:bertug_vatansever/data/repo/food_repository.dart';
import 'package:bertug_vatansever/main.dart';
import 'package:bertug_vatansever/ui/cubit/box_cubit.dart';
import 'package:bertug_vatansever/ui/cubit/food_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BoxDetailPage extends StatefulWidget {
  final Food food;
  BoxDetailPage({super.key, required this.food});

  @override
  State<BoxDetailPage> createState() => _BoxDetailPageState();
}

class _BoxDetailPageState extends State<BoxDetailPage> {
  int quantity = 1; // Adet kontrolü için

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColor.white,
        backgroundColor: AppColor.primaryColor,
        centerTitle: true,
        title: Text(
          "Yemek Detayı",
          style: TextStyle(color: AppColor.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Yemek Resmi
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  "http://kasimadalan.pe.hu/yemekler/resimler/${widget.food.foodImageName}",
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: 250,
                ),
              ),

              SizedBox(height: 20),

              // Yemek Adı
              Text(
                widget.food.foodName,
                style: TextStyle(
                  color: AppColor.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 15),

              // Açıklama Alanı
              Text(
                "Lezzetli ve baharatlı tantuni, özel soslarla hazırlanmış enfes bir Türk yemeğidir.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[700], fontSize: 18),
              ),

              SizedBox(height: 35),

              // Adet Seçme Butonları
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildQuantityButton(Icons.remove, () {
                    if (quantity > 1) {
                      setState(() {
                        quantity--;
                      });
                    }
                  }),
                  SizedBox(width: 20),
                  Text(
                    "$quantity",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 20),
                  _buildQuantityButton(Icons.add, () {
                    setState(() {
                      quantity++;
                    });
                  }),
                ],
              ),

              SizedBox(height: 40),

              // Fiyat Bilgisi
              Text(
                "${widget.food.foodPrice * quantity} TL",
                style: TextStyle(
                  color: AppColor.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 40),

              // Sepete Ekle Butonu
              ElevatedButton(
                onPressed: () async {
                  widget.food.foodNumber = quantity;
                  context.read<FoodCubit>().addToBox(widget.food, "bertug");
                  await context
                      .read<BoxCubit>()
                      .fetchBoxFoods(userName: "bertug");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryColor,
                  foregroundColor: AppColor.white,
                  fixedSize: Size(180, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                ),
                child: Text(
                  "Sepete Gönder",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Adet Buton Tasarımı
  Widget _buildQuantityButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColor.primaryColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              spreadRadius: 1,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, color: AppColor.white),
      ),
    );
  }
}
