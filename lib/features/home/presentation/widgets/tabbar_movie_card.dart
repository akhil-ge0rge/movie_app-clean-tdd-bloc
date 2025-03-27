import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class TabbarMovieCard extends StatelessWidget {
  final double scrHeight;
  final double scrWidth;
  const TabbarMovieCard({
    super.key,
    required this.scrHeight,
    required this.scrWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(18),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: CachedNetworkImage(
          imageUrl:
              "https://image.tmdb.org/t/p/original/gh4cZbhZxyTbgxQPxD0dOudNPTn.jpg",
          fit: BoxFit.fill,
          memCacheHeight:
              ((scrHeight * 0.24).toInt() *
                      MediaQuery.of(context).devicePixelRatio)
                  .round(),
          memCacheWidth:
              ((scrWidth * 0.4).toInt() *
                      MediaQuery.of(context).devicePixelRatio)
                  .round(),
        ),
      ),
    );
  }
}
