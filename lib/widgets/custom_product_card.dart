import 'package:excellent_practical_interview/screens/home/logic.dart';
import 'package:excellent_practical_interview/utills/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'custom_button.dart';

class CustomProductCardWidget extends StatefulWidget {
  final String? title;
  final int? index;
  final int? price;
   bool isFavorite;
  int isCartQuantity;
  final Function()? addCart;

  final int? uid;

  CustomProductCardWidget({
    super.key,
    this.title,
    this.index,
    this.price,
    this.isFavorite = false,
    this.isCartQuantity = 0,
    this.addCart,
    this.uid,
  });

  @override
  State<CustomProductCardWidget> createState() =>
      _CustomProductCardWidgetState();
}

class _CustomProductCardWidgetState extends State<CustomProductCardWidget> {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
              flex: 3,
              child: randomImageGenerator(widget.index ?? 0,
                  width: MediaQuery.sizeOf(context).width)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  widget.title!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.sp,
                  ),
                ),
              ),
              Expanded(
                  child: widget.isFavorite == false
                      ? IconButton(
                          onPressed: () {
                            widget.isFavorite = true;
                            Get.put<HomeLogic>(HomeLogic())
                                .addRemoveFavM(true, widget.index);
                          }, icon: const Icon(Icons.favorite_border))
                      : IconButton(
                          onPressed: () {
                            widget.isFavorite = false;
                            Get.put<HomeLogic>(HomeLogic())
                                .addRemoveFavM(false, widget.index);
                          },
                          icon: Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )))
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.star_purple500_sharp,
                color: Colors.yellow,
                size: 10.sp,
              ),
              Icon(
                Icons.star_purple500_sharp,
                color: Colors.yellow,
                size: 10.sp,
              ),
              Icon(
                Icons.star_purple500_sharp,
                color: Colors.yellow,
                size: 10.sp,
              ),
              Icon(
                Icons.star_purple500_sharp,
                color: Colors.yellow,
                size: 10.sp,
              ),
              Icon(
                Icons.star_purple500_sharp,
                color: Colors.yellow,
                size: 10.sp,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$${widget.price}",
                style: TextStyle(fontSize: 14.sp),
              ),
              widget.isCartQuantity == 0
                  ? SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.15,
                      child: CustomButtonWidget(
                        text: "Add",
                        onTap: widget.addCart!,
                      ),
                    )
                  : Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                widget.isCartQuantity =
                                    widget.isCartQuantity + 1;
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
                                  widget.isCartQuantity =
                                      widget.isCartQuantity - 1;
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
        ],
      ),
    );
  }
}
