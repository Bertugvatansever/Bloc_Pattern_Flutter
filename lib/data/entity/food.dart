class Food {
  int foodId;
  String foodName;
  String foodImageName;
  int foodPrice;
  int? foodNumber;
  String? userName;

  Food({
    required this.foodId,
    required this.foodName,
    required this.foodImageName,
    required this.foodPrice,
    this.foodNumber,
    this.userName,
  });

  // JSON'dan nesneye dönüştürme
  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      foodId: json['yemek_id'] is int
          ? json['yemek_id']
          : int.parse(json['yemek_id']),
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
      "yemek_id": foodId,
      "yemek_adi": foodName,
      "yemek_resim_adi": foodImageName,
      "yemek_fiyat": foodPrice.toString(),
      "yemek_siparis_adet": foodNumber?.toString(),
      "kullanici_adi": userName,
    };
  }
}
