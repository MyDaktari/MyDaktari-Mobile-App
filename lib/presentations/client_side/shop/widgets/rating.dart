import 'package:flutter/material.dart';
import 'package:my_daktari/constants/colors.dart';

List<Widget> buildStarRating(double rating) {
  int filledStars = rating.round();

  List<Widget> stars = [];

  for (int i = 1; i <= 5; i++) {
    if (i <= filledStars) {
      stars.add(Icon(Icons.star, color: AppColor.ratingColor));
    } else {
      stars.add(Icon(Icons.star_border, color: AppColor.ratingColor));
    }
  }
  return stars;
}
