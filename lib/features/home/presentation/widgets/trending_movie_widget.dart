import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/extensions/media_query_extensions.dart';
import 'package:movie_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:movie_app/features/home/presentation/widgets/trending_movie_card.dart';

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
              return const Center(child: CircularProgressIndicator());
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
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    separatorBuilder:
                        (context, index) => (scrWidth * 0.04).width,
                    itemCount:
                        state.trendingMoviePaginationLoading
                            ? state.trendingMovie.length + 1
                            : state.trendingMovie.length,
                    itemBuilder: (context, index) {
                      if (state.trendingMoviePaginationLoading) {
                        if (index == state.trendingMovie.length) {
                          return const Center(
                            child: CircularProgressIndicator.adaptive(
                              backgroundColor: Colors.yellowAccent,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.yellowAccent,
                              ),
                            ),
                          );
                        }
                      }

                      final movie = state.trendingMovie.elementAt(index);
                      return TrendingMovieCard(
                        index: index,
                        movie: movie,
                        scrHeight: scrHeight,
                        scrWidth: scrWidth,
                        textTheme: textTheme,
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
