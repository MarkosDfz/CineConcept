
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class RankingWidget extends StatelessWidget {

  final double ratingValue;

  RankingWidget( { @required this.ratingValue } );

  @override
  Widget build(BuildContext context) {

    return SmoothStarRating(
      allowHalfRating: false,
      starCount: 5,
      rating: ratingValue / 2,
      size: 20.0,
      isReadOnly:true,
      color: Colors.orange,
      borderColor: Colors.orange,
      spacing:0.0
    );

  }

}