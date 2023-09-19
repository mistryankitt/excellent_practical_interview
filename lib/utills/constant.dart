import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

randomImageGenerator(id,{height, width}){
  return ClipRRect(
    borderRadius: BorderRadius.circular(10).r,
    child: Image.network(
      "https://picsum.photos/id/$id/200/300",
      height: height,
      width: width,
      fit: BoxFit.cover,
    ),
  );
}