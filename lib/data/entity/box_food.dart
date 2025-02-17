class BoxFood {
  int foodId;
  String foodName;
  String foodImageName;
  int foodPrice;
  int? foodNumber;
  int? totalPrice;
  String? userName;

  BoxFood({
    required this.foodId,
    required this.foodName,
    required this.foodImageName,
    required this.foodPrice,
    this.foodNumber,
    this.userName,
  });

  // JSON'dan nesneye dönüştürme
  factory BoxFood.fromJson(Map<String, dynamic> json) {
    return BoxFood(
      foodId: int.parse(json["sepet_yemek_id"]),
      foodName: json["yemek_adi"] as String,
      foodImageName: json["yemek_resim_adi"] as String,
      foodPrice: int.parse(json["yemek_fiyat"]),
      foodNumber: json["yemek_siparis_adet"] != null
          ? int.parse(json["yemek_siparis_adet"])
          : null,
      userName: json["kullanici_adi"],
    );
  }

  // Nesneyi JSON'a dönüştürme
  Map<String, dynamic> toJson() {
    return {
      "Food_id": foodId,
      "Food_adi": foodName,
      "Food_resim_adi": foodImageName,
      "Food_fiyat": foodPrice.toString(),
      "Food_siparis_adet": foodNumber?.toString(),
      "kullanici_adi": userName,
    };
  }
}
