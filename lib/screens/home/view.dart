import 'package:excellent_practical_interview/screens/routes.dart';
import 'package:excellent_practical_interview/utills/constant.dart';
import 'package:excellent_practical_interview/widgets/custom_product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'logic.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final logic = Get.find<HomeLogic>();
  final state = Get.find<HomeLogic>().state;

  @override
  Widget build(BuildContext context) {
    logic.getProductApiM();
    return Scaffold(
      body: GetBuilder<HomeLogic>(
          init: logic,
          builder: (logic) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: const Text("Excellent world web"),
                  actions: [
                    IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRouter.cartPage)
                              .then((value) {
                            logic.update();
                          });
                        },
                        icon: const Icon(Icons.add_shopping_cart_outlined)),
                    IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRouter.favPage)
                              .then((value) {
                            logic.update();
                          });                        },
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )),
                    IconButton(
                        onPressed: () {
                          logic.removeLocalData();
                        },
                        icon: const Icon(Icons.clear_all))
                  ],
                ),
                if (logic.getProductListModel == null)
                  const SliverToBoxAdapter(
                    child: LinearProgressIndicator(),
                  ),
                if (logic.getProductListModel != null)
                  SliverToBoxAdapter(
                    child: GridView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(15),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: logic.getProductListModel!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 15),
                        itemBuilder: (context, index) {
                          return CustomProductCardWidget(
                            index: index,
                            uid: logic.getProductListModel?[index].userId,
                            price: logic.getProductListModel![index].price!,
                            title: logic.getProductListModel?[index].title,
                            isFavorite:
                                logic.getProductListModel![index].isFavorite,
                            isCartQuantity: logic
                                .getProductListModel![index].isCartQuantity,
                            addCart: () {
                              logic.incrementQuantity(index);
                            },
                          );
                        }),
                  )
              ],
            );
          }),
    );
  }
}
