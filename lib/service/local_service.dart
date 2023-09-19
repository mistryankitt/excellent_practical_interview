import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import '../utills/local_data_variable.dart';

class LocalDataService {
  ///set favorite product list in local data
  static setFavoriteList(String? favList) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(favoriteListKey, favList!);
  }

  ///set cart product list in local data
  static setCartList(dynamic cartList) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(cartListKey, jsonEncode(cartList));
  }

  ///set product list in local data
  static setProductList(dynamic productList) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(productListKey, jsonEncode(productList));
  }

  ///get product list in local data
  static Future<String?> getProductList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(productListKey);
  }

  ///get cart product list in local data
  static Future<String?> getCartList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    log("${preferences.getString(cartListKey)}");
    return preferences.getString(cartListKey);
  }
}
