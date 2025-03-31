import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/extensions/media_query_extensions.dart';

import '../bloc/movie_details_bloc.dart';
import 'movie_poster_and_name_widget.dart';
import 'movie_tiny_detail_widget.dart';

class MovieDetailTopSection extends StatelessWidget {
  const MovieDetailTopSection({super.key});

  @override
  Widget build(BuildContext context) {
    double scrHeight = context.mediaQueryHeight;
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
      builder: (context, state) {
        if (state is MovieDetailsLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (state is MovieDetailsError) {
          return Text(state.message);
        } else if (state is MovieDetailsLoaded) {
          final movie = state.movie;
          return Column(
            children: [
              MoviePosterAndNameWidget(movie: movie),
              SizedBox(height: scrHeight * 0.02),
              MovieTinyDetailWidget(movie: movie),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
