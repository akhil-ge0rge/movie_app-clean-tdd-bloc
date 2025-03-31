import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:movie_app/core/extensions/media_query_extensions.dart';

class MoviePosterAndNameWidget extends StatelessWidget {
  const MoviePosterAndNameWidget({super.key});

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
                  imageUrl:
                      'https://media.themoviedb.org/t/p/w500_and_h282_face/n6bUvigpRFqSwmPp1m2YADdbRBc.jpg',
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
                    imageUrl:
                        "https://media.themoviedb.org/t/p/w600_and_h900_bestv2/39jIr3A4ScUeGxFdMeARYKNxTgU.jpg",
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

              child: Text(
                "Spiderman No Way Home",
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
