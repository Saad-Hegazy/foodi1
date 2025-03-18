import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/model/itemsmodel.dart';

class FavoriteController extends GetxController {

  final RxList<ItemsModel> _favoriteItems = <ItemsModel>[].obs;
  final String _favoritesKey = 'favorites';

  List<ItemsModel> get favorites => _favoriteItems;

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesString = prefs.getStringList(_favoritesKey);

    if (favoritesString != null) {
      _favoriteItems.value = favoritesString.map((item) =>
          ItemsModel.fromJson(json.decode(item))).toList();
    }
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesString = _favoriteItems.map((item) =>
        json.encode(item.toJson())).toList();
    await prefs.setStringList(_favoritesKey, favoritesString);
  }

  bool isFavorite(ItemsModel itemsModel) {
    return _favoriteItems.any((item) => item.itemsId == itemsModel.itemsId);
  }

  void toggleFavorite(ItemsModel itemsModel) {
    if (isFavorite(itemsModel)) {
      _favoriteItems.removeWhere((item) => item.itemsId == itemsModel.itemsId);
    } else {
      _favoriteItems.add(itemsModel);
    }
    _saveFavorites();
    update();
  }

  goToPageProductDetails(itemsModel) {
    Get.toNamed("productdetails", arguments: {"itemsmodel": itemsModel});
  }


}