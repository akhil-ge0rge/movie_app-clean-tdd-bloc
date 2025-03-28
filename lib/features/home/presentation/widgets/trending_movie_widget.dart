import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/constants/app_url.dart';
import 'package:movie_app/core/extensions/media_query_extensions.dart';
import 'package:movie_app/features/home/presentation/bloc/home_bloc.dart';

class TrendingMovieWidget extends StatelessWidget {
  const TrendingMovieWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double scrHeight = context.mediaQueryHeight;
    double scrWidth = context.mediaQueryWidth;
    TextTheme textTheme = context.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Text("Trending Movies", style: textTheme.bodySmall),
        ),
        (scrHeight * 0.02).height,
        BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state.trendingMovieLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.trendingMovieError != null) {
              return Center(child: Text(state.trendingMovieError.toString()));
            } else {
              return SizedBox(
                height: scrHeight * 0.26,
                width: scrWidth,
                child: NotificationListener(
                  onNotification: (ScrollNotification scrollNoti) {
                    if (scrollNoti.metrics.pixels ==
                        scrollNoti.metrics.maxScrollExtent) {
                      context.read<HomeBloc>().add(FetchTrendingMovies());
                    }
                    return false;
                  },
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    separatorBuilder:
                        (context, index) => (scrWidth * 0.04).width,
                    itemCount: state.trendingMovie.length,
                    itemBuilder: (context, index) {
                      final movie = state.trendingMovie.elementAt(index);
                      return Stack(
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
                                    AppUrl.imageBaseURL + movie.posterPath,
                                fit: BoxFit.fill,
                                memCacheHeight:
                                    ((scrHeight * 0.24).toInt() *
                                            MediaQuery.of(
                                              context,
                                            ).devicePixelRatio)
                                        .round(),
                                memCacheWidth:
                                    ((scrWidth * 0.4).toInt() *
                                            MediaQuery.of(
                                              context,
                                            ).devicePixelRatio)
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
                      );
                    },
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
