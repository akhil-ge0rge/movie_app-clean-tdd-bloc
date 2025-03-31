import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/common/feature/movie_details/domain/entities/movie_detail.dart';

import 'package:movie_app/core/constants/app_url.dart';

import 'package:movie_app/core/extensions/media_query_extensions.dart';

class MoviePosterAndNameWidget extends StatelessWidget {
  final MovieDetail movie;
  const MoviePosterAndNameWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    double scrHeight = context.mediaQueryHeight;
    double scrWidth = context.mediaQueryWidth;
    TextTheme textTheme = context.textTheme;
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: scrWidth,
              height: scrHeight * 0.24,
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: AppUrl.imageBaseURL + movie.backdropPath,
                ),
              ),
            ),
            Positioned(
              bottom: -(scrHeight * 0.083),
              left: scrWidth * 0.057,
              child: Container(
                height: scrHeight * 0.18,
                width: scrWidth * 0.3,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.red,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    imageUrl: AppUrl.imageBaseURL + movie.posterPath,
                    memCacheHeight:
                        ((scrHeight * 0.18).toInt() *
                                MediaQuery.of(context).devicePixelRatio)
                            .round(),
                    memCacheWidth:
                        ((scrWidth * 0.3).toInt() *
                                MediaQuery.of(context).devicePixelRatio)
                            .round(),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: scrHeight * 0.01),
        Row(
          children: [
            SizedBox(width: scrWidth * 0.4),
            SizedBox(
              width: scrWidth * 0.6,
              height: scrHeight * 0.08,
              child: Text(
                movie.originalTitle,
                style: textTheme.bodyMedium?.copyWith(fontSize: 20),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
