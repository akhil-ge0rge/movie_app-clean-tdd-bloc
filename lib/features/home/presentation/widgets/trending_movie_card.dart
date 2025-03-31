import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/common/entities/movie.dart';
import 'package:movie_app/core/constants/app_url.dart';
import 'package:movie_app/core/routes/route_names.dart';

class TrendingMovieCard extends StatelessWidget {
  final double scrHeight;
  final double scrWidth;
  final Movie movie;
  final int index;
  final TextTheme textTheme;
  const TrendingMovieCard({
    super.key,
    required this.scrHeight,
    required this.scrWidth,
    required this.movie,
    required this.index,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(RouteNames.movieDetailsScreen);
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: scrHeight * 0.24,
            width: scrWidth * 0.4,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
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
                errorWidget: (context, url, error) {
                  return CachedNetworkImage(
                    imageUrl: AppUrl.brokenImageURL,
                    fit: BoxFit.fill,
                    memCacheHeight:
                        ((scrHeight * 0.24).toInt() *
                                MediaQuery.of(context).devicePixelRatio)
                            .round(),
                    memCacheWidth:
                        ((scrWidth * 0.4).toInt() *
                                MediaQuery.of(context).devicePixelRatio)
                            .round(),
                  );
                },
              ),
            ),
          ),
          Positioned(
            bottom: -25,
            left: -10,
            child: Text(
              (index + 1).toString(),
              style: textTheme.bodyLarge?.copyWith(
                fontSize: 80,

                foreground:
                    Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 4
                      ..color = Colors.blueAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
