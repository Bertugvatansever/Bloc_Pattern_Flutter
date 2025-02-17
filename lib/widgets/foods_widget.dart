import 'package:bertug_vatansever/app_colors.dart';
import 'package:bertug_vatansever/data/entity/food.dart';
import 'package:flutter/material.dart';

class FoodWidget {
  Widget foodListWidget(Food yemek) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 6,
            spreadRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Yemek Resmi
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                "http://kasimadalan.pe.hu/yemekler/resimler/${yemek.foodImageName}",
                width: double.infinity,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Yemek Adı
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              yemek.foodName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          Spacer(),

          // Fiyat ve Puan
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "${yemek.foodPrice.toString()} TL",
                  style: TextStyle(
                    color: AppColor.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.orange, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      4.toString(),
                      style: TextStyle(color: AppColor.black, fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const Spacer(),

          // Sepete Ekle Butonu
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: SizedBox(
              width: double.infinity,
              height: 32,
              child: ElevatedButton(
                onPressed: () {
                  // Sepete ekleme işlemi
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryColor,
                  foregroundColor: AppColor.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text("Ürün Detayı",
                    style: TextStyle(fontSize: 14, color: AppColor.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
