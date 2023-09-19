import 'dart:developer';

import 'package:excellent_practical_interview/model/product_model.dart';
import 'package:excellent_practical_interview/service/api_service.dart';
import 'package:excellent_practical_interview/service/local_service.dart';
import 'package:excellent_practical_interview/utills/api_endpoint.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'state.dart';

class HomeLogic extends GetxController {
  final HomeState state = HomeState();

  List<GetProductListModel>? getProductListModel;

  int totalQuantity = 0;
  double totalPrice = 0.0;

  Future<int> calculateTotalQuantity() async {
    totalQuantity = 0;
    totalPrice = 0.0;

    final data = await LocalDataService.getProductList();
    getProductListModel = getProductListModelFromJson(data!);

    for (var product in getProductListModel!) {
      if (product.isCartQuantity > 0) {
        totalQuantity += product.isCartQuantity;
        totalPrice += product.isCartQuantity * product.price;
      }
    }

    print('Total Quantity: $totalQuantity');
    print('Total Price: \$${totalPrice.toStringAsFixed(2)}');

    return totalQuantity;
  }

  void getProductApiM() async {
    if (await LocalDataService.getProductList() != null) {
      final data = await LocalDataService.getProductList();
      getProductListModel = getProductListModelFromJson(data!);
      for (var i in getProductListModel!) {
        if (i.isCartQuantity > 0) {
          log(i.isCartQuantity.toString());
        }
      }
      update();
    } else {
      await ApiService.getApi(endPoint: ApiEndPoint.getProductListAPI)
          .then((value) async {
        if (value != null) {
          final data = value.body;
          getProductListModel = getProductListModelFromJson(data);
          LocalDataService.setProductList(getProductListModel!);
          update();
        }
      });
    }
  }

  void removeLocalData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    update();
  }

  void removeCart(index) async {
    log(index.toString());
    if (await LocalDataService.getProductList() != null) {
      final productData = await LocalDataService.getProductList();
      getProductListModel = getProductListModelFromJson(productData!);
      getProductListModel![index].isCartQuantity = 0;
      await LocalDataService.setProductList(getProductListModel);
      update();
    }
  }

  // Function to increment the quantity of a product based on uid.
  void incrementQuantity(int index) async {
    final productData = await LocalDataService.getProductList();
    getProductListModel = getProductListModelFromJson(productData!);
    getProductListModel![index].isCartQuantity =
        getProductListModel![index].isCartQuantity + 1;
    LocalDataService.setProductList(getProductListModel!);
    calculateTotalQuantity();

    update();
  }

// Function to decrement the quantity of a product based on uid.
  void decrementQuantity(int index) async {
    final productData = await LocalDataService.getProductList();
    getProductListModel = getProductListModelFromJson(productData!);
    getProductListModel![index].isCartQuantity =
        getProductListModel![index].isCartQuantity - 1;
    // Update SharedPreferences.
    LocalDataService.setProductList(getProductListModel!);
    calculateTotalQuantity();

    update();
  }

  void addRemoveFavM(bool isFav, index) async {
    final productData = await LocalDataService.getProductList();
    getProductListModel = getProductListModelFromJson(productData!);

    getProductListModel![index].isFavorite = isFav;

    LocalDataService.setProductList(getProductListModel!);
    update();
  }
}
