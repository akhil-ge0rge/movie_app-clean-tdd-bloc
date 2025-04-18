import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_app/core/extensions/media_query_extensions.dart';

import '../bloc/movie_details_bloc.dart';

class AboutWidget extends StatelessWidget {
  const AboutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = context.textTheme;
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
      builder: (context, state) {
        if (state is MovieDetailsLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (state is MovieDetailsError) {
          return Text(state.message);
        } else if (state is MovieDetailsLoaded) {
          final movie = state.movie;
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ).copyWith(top: 20),
            child: Text(
              movie.overview,
              style: textTheme.bodySmall?.copyWith(fontSize: 13),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
