import 'package:remindbless/core/app_assets.dart';
import 'package:remindbless/data/models/category/category_model.dart';

class HomeCategoryItem {
  final String idCategory;
  final String assetPath;
  final String label;
  const HomeCategoryItem(this.idCategory, this.assetPath, this.label);
}

final List<HomeCategoryItem> itemsHomeCategory = [
  HomeCategoryItem("ALL", Assets.iconCoffeeMenu, 'Tất cả'),
  HomeCategoryItem("FOOD", Assets.iconFood, 'Món ăn'),
  HomeCategoryItem("COFFEE", Assets.iconLatteArt, 'Cà phê'),
  HomeCategoryItem("MILKTEA", Assets.iconSoftDrinks3d, 'Trà sữa'),
  HomeCategoryItem("FLOAT", Assets.iconFloat, 'Đá xay'),
  HomeCategoryItem("CAKE", Assets.iconChocolate, 'Bánh ngọt'),
  HomeCategoryItem("CREAM", Assets.iconIceCream, 'Kem'),
  HomeCategoryItem("OTHER", Assets.iconReceptionBell, 'Món thêm'),
];

final List<Map<String, dynamic>> itemsCategoryYouChoose = [
  {"title": "ĐỒ UỐNG CÀ PHÊ", "imageUrl": Assets.imgViewCoffeeCup},
  {"title": "ĐỒ UỐNG KHÔNG CÀ PHÊ", "imageUrl": Assets.imgJuiceCategory},
  {"title": "ĐỒ ĂN – BÁNH NGỌT", "imageUrl": Assets.imgFoodDesserts},
  {"title": "ĂN VẶT - ĂN KÈM", "imageUrl": Assets.imgSnacksSideDishes},
];

final banners = [Assets.imgBanner1, Assets.imgBanner2, Assets.imgBanner3, Assets.imgBanner4, Assets.imgBanner5];