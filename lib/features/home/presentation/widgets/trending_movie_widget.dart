import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/extensions/media_query_extensions.dart';

class TrendingMovieWidget extends StatelessWidget {
  const TrendingMovieWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double scrHeight = context.mediaQueryHeight;
    double scrWidth = context.mediaQueryWidth;
    TextTheme textTheme = context.textTheme;

    print("${scrHeight * 0.24} ${scrWidth * 0.4}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Text("Trending Movies", style: textTheme.bodySmall),
        ),
        (scrHeight * 0.02).height,
        SizedBox(
          height: scrHeight * 0.26,
          width: scrWidth,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 25),
            separatorBuilder: (context, index) => (scrWidth * 0.04).width,
            itemCount: 4,
            itemBuilder:
                (context, index) => Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: scrHeight * 0.24,
                      width: scrWidth * 0.4,
                      decoration: BoxDecoration(
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
          ),
        ),
      ],
    );
  }
}
