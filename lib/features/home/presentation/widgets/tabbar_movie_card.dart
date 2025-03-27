import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/common/entities/movie.dart';
import 'package:movie_app/core/constants/app_url.dart';

class TabbarMovieCard extends StatelessWidget {
  final double scrHeight;
  final double scrWidth;
  final Movie movie;
  const TabbarMovieCard({
    super.key,
    required this.scrHeight,
    required this.scrWidth,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(18),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: CachedNetworkImage(
          imageUrl: AppUrl.imageBaseURL + movie.posterPath,
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
