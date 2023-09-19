import 'package:excellent_practical_interview/screens/home/logic.dart';
import 'package:excellent_practical_interview/widgets/cart_card_widget.dart';
import 'package:excellent_practical_interview/widgets/custom_fav_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class FavoritePage extends StatelessWidget {
  FavoritePage({Key? key}) : super(key: key);

  final logic = Get.find<FavoriteLogic>();
  final homeLogic = Get.find<HomeLogic>();
  final state = Get.find<FavoriteLogic>().state;

  @override
  Widget build(BuildContext context) {
    homeLogic.getProductApiM();

    return Scaffold(
      body: GetBuilder<HomeLogic>(
          init: homeLogic,
          builder: (logic) {
            return CustomScrollView(
              slivers: [
                const SliverAppBar(
                  title: Text("Favorite Screen"),
                ),
                SliverToBoxAdapter(
                  child: ListView.builder(
                      itemCount: logic.getProductListModel!.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                          return logic.getProductListModel![index].isFavorite == true ?  Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: CustomFavCardWidget(
                              uid: logic.getProductListModel![index].userId!,
                              title: logic.getProductListModel?[index].title,
                              index: index,
                              price: "\$${logic.getProductListModel![index].price}",
                              isCartQuantity: logic.getProductListModel![index].isCartQuantity,
                            ),
                          ) : Container();

                      }),
                )
              ],
            );
          }),
    );
  }
}
