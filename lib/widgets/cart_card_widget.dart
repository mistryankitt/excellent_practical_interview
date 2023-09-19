import 'package:excellent_practical_interview/screens/home/logic.dart';
import 'package:excellent_practical_interview/utills/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'custom_button.dart';

class CartCardWidget extends StatefulWidget {
  final String? title;
  final int? index;
  final int uid;
  final String? price;
  final bool? isFavorite;
  int isCartQuantity;
  final Function()? addCart;

  CartCardWidget({
    super.key,
    this.title,
    this.index,
    this.price,
    this.isFavorite,
    this.isCartQuantity = 0,
    this.addCart,
    required this.uid,
  });

  @override
  State<CartCardWidget> createState() => _CartCardWidgetState();
}

class _CartCardWidgetState extends State<CartCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.15,
                height: MediaQuery.sizeOf(context).height * 0.15,
                child: randomImageGenerator(widget.index),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${widget.title}"),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text("${widget.price}"),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        widget.isCartQuantity = widget.isCartQuantity + 1;
                        Get.put<HomeLogic>(HomeLogic())
                            .incrementQuantity(widget.index!);
                      });
                    },
                    icon: const Icon(Icons.add)),
                Text(
                  "${widget.isCartQuantity}",
                  style: TextStyle(fontSize: 14.sp),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        if (widget.isCartQuantity == 1) {
                          widget.isCartQuantity = 0;
                          Get.put<HomeLogic>(HomeLogic())
                              .removeCart(widget.index);
                        } else {
                          widget.isCartQuantity = widget.isCartQuantity - 1;
                          Get.put<HomeLogic>(HomeLogic())
                              .decrementQuantity(widget.index!);
                        }
                      });
                    },
                    icon: const Icon(Icons.remove)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
