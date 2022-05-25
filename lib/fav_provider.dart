import 'package:firebase_model/product_model.dart';
import 'package:flutter/cupertino.dart';

import 'db.dart';


class FavouritesProvider extends ChangeNotifier {
  final DatabaseHelperDb _db = DatabaseHelperDb.instance;
  List<FavouritesModel>? favList;

  Future<void> insertFavItems(Value value) async {
    await _db.createFavouritesList(value);
    await loadFavList();
    notifyListeners();
  }

  Future<void> loadFavList() async {
    favList = await DatabaseHelperDb.instance.getFavoritesList();
    notifyListeners();
  }

  Future<void> deleteFavouritesItem(int? id) async {
    await DatabaseHelperDb.instance.deleteFavItem(id);
    await loadFavList();
    notifyListeners();
  }
}