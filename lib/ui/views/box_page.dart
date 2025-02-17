import 'package:bertug_vatansever/data/entity/box_food.dart';
import 'package:bertug_vatansever/ui/cubit/box_cubit.dart';
import 'package:flutter/material.dart';
import 'package:bertug_vatansever/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BoxPage extends StatelessWidget {
  BoxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        centerTitle: true,
        title: Text(
          "Sepetim",
          style: TextStyle(color: AppColor.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<BoxCubit, List<BoxFood>>(
              builder: (context, boxFoodList) {
                final cubit = context.read<BoxCubit>();
                if (cubit.isLoading) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: AppColor.primaryColor,
                  ));
                }
                if (cubit.isLoading == false && boxFoodList.isEmpty) {
                  return Center(child: Text("Sepetiniz boş"));
                }

                return ListView.builder(
                  itemCount: boxFoodList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      child: Container(
                        width: double.infinity,
                        height: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              spreadRadius: 2,
                              offset: Offset(0, 4),
                            )
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  "http://kasimadalan.pe.hu/yemekler/resimler/${boxFoodList[index].foodImageName}",
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  boxFoodList[index].foodName,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 12),
                                Text("Fiyat: ${boxFoodList[index].foodPrice}",
                                    style: TextStyle(fontSize: 14)),
                                SizedBox(height: 12),
                                Text("Adet: ${boxFoodList[index].foodNumber}",
                                    style: TextStyle(fontSize: 14)),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    color: Colors.red,
                                    onPressed: () async {
                                      bool _temp = await context
                                          .read<BoxCubit>()
                                          .deleteBoxFood(
                                              boxFoodList[index].foodId,
                                              "bertug");
                                      if (_temp) {
                                        print("Ürün sepetten silindi");
                                      } else {
                                        print("Silinirken bir hata oluştu");
                                      }
                                    },
                                    icon: Icon(Icons.delete, size: 30),
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    "${boxFoodList[index].foodPrice * (boxFoodList[index].foodNumber ?? 0)}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          // Toplam Fiyat Hesaplama
          BlocSelector<BoxCubit, List<BoxFood>, double>(
            selector: (boxFoodList) {
              return boxFoodList.fold(
                  0, (total, food) => total + (food.totalPrice ?? 0));
            },
            builder: (context, totalBoxPrice) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Text(
                        "Toplam: ",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Text(
                        "${totalBoxPrice} TL",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColor.primaryColor),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                "Sepeti Onayla",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(300, 50),
                backgroundColor: AppColor.primaryColor,
                foregroundColor: AppColor.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
