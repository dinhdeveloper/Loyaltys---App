
import 'package:remindbless/core/app_assets.dart';

class IconItem {
  final String assetPath;
  final String label;
  const IconItem(this.assetPath, this.label);
}

final List<IconItem> itemsHomeCategory = [
  IconItem(Assets.iconCoffeeMenu, 'Tất cả'),
  IconItem(Assets.iconFood, 'Món ăn'),
  IconItem(Assets.iconLatteArt, 'Cà phê'),
  IconItem(Assets.iconSoftDrinks3d, 'Trà sữa'),
  IconItem(Assets.iconFloat, 'Đá xay'),
  IconItem(Assets.iconChocolate, 'Bánh ngọt'),
  IconItem(Assets.iconIceCream, 'Kem'),
  IconItem(Assets.iconReceptionBell, 'Món thêm'),
];

final jsonMegaSale = {
  "items": [
    {"title": "Americano", "discount": "-10%", "oldPrice": 55000, "price": 49500, "imageUrl": Assets.iconColdCoffeeCup},
    {"title": "Hamburger", "discount": "-50%", "oldPrice": 65000, "price": 55000, "imageUrl": Assets.imgHamburger},
    {"title": "Buritto", "discount": "-30%", "oldPrice": 45000, "price": 40000, "imageUrl": Assets.imgBuritto},
    {"title": "Cake", "discount": "-20%", "oldPrice": 40000, "price": 32000, "imageUrl": Assets.imgCake},
    {"title": "Cold Brew", "discount": "-25%", "oldPrice": 38000, "price": 28500, "imageUrl": Assets.iconCoffee2},
    {"title": "Carrot Juice", "discount": "-15%", "oldPrice": 42000, "price": 35700, "imageUrl": Assets.imgCarrotJuice},
    {"title": "Spoghetti", "discount": "-35%", "oldPrice": 50000, "price": 32500, "imageUrl": Assets.imgSpoghetti},
  ]
};

final List<Map<String, dynamic>> itemsCategoryYouChoose = [
  {"title": "ĐỒ UỐNG CÀ PHÊ", "imageUrl": Assets.imgViewCoffeeCup},
  {"title": "ĐỒ UỐNG KHÔNG CÀ PHÊ", "imageUrl": Assets.imgJuiceCategory},
  {"title": "ĐỒ ĂN – BÁNH NGỌT", "imageUrl": Assets.imgFoodDesserts},
  {"title": "ĂN VẶT - ĂN KÈM", "imageUrl": Assets.imgSnacksSideDishes}
];