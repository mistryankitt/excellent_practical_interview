import 'package:excellent_practical_interview/screens/cart/binding.dart';
import 'package:excellent_practical_interview/screens/cart/view.dart';
import 'package:excellent_practical_interview/screens/favorite/binding.dart';
import 'package:excellent_practical_interview/screens/favorite/view.dart';
import 'package:excellent_practical_interview/screens/home/binding.dart';
import 'package:excellent_practical_interview/screens/home/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppRouter {
  static const homePage = "/";
  static const favPage = "/favPage";
  static const cartPage = "/cartPage";

  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case favPage:
        return GetPageRoute(
            page: () => FavoritePage(), binding: FavoriteBinding());
      case cartPage:
        return GetPageRoute(page: () => CartPage(), binding: CartBinding());
      case homePage:
        return GetPageRoute(page: () => HomePage(), binding: HomeBinding());
    }
    return null;
  }
}
