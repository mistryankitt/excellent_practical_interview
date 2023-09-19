import 'package:excellent_practical_interview/screens/home/logic.dart';
import 'package:excellent_practical_interview/utills/constant.dart';
import 'package:excellent_practical_interview/widgets/cart_card_widget.dart';
import 'package:excellent_practical_interview/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'logic.dart';

class CartPage extends StatelessWidget {
  CartPage({Key? key}) : super(key: key);

  final logic = Get.find<CartLogic>();

  final homeLogic = Get.put<HomeLogic>(HomeLogic());

  final state = Get
      .find<CartLogic>()
      .state;

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
                  title: Text("Cart Screen"),
                ),
                SliverToBoxAdapter(
                  child: ListView.builder(
                      itemCount: logic.getProductListModel?.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return logic.getProductListModel![index]
                            .isCartQuantity > 0 ? Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: CartCardWidget(
                              uid: logic.getProductListModel![index].userId!,
                              title: logic.getProductListModel?[index].title,
                              index: index,
                              price: "\$${logic.getProductListModel![index]
                                  .price}",
                              isCartQuantity: logic.getProductListModel![index]
                                  .isCartQuantity,
                            )
                        ) : Container();
                      }),
                )
              ],
            );
          }),
      bottomSheet: GetBuilder(
          init: homeLogic,
          builder: (logic) {
            return Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 1.0),
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 2,
                        spreadRadius: 2)
                  ]),
              child: Container(
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: Text("\$${logic.totalPrice}")),
                      Expanded(child: CustomButtonWidget(onTap: (){}, text: "Checkout"))
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
