import 'package:excellent_practical_interview/screens/home/logic.dart';
import 'package:excellent_practical_interview/utills/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'custom_button.dart';

class CustomFavCardWidget extends StatefulWidget {
  final String? title;
  final int? index;
  final int uid;
  final String? price;
  final bool? isFavorite;
  int isCartQuantity;
  final Function()? addCart;

  CustomFavCardWidget({
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
  State<CustomFavCardWidget> createState() => _CustomFavCardWidgetState();
}

class _CustomFavCardWidgetState extends State<CustomFavCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.12),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.15,
                height: MediaQuery.sizeOf(context).height * 0.15,
                child: randomImageGenerator(widget.index),
              ),
              Expanded(
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
              IconButton(
                  onPressed: () {
                    Get.put<HomeLogic>(HomeLogic())
                        .addRemoveFavM(false, widget.index);
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
