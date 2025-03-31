import 'package:flutter/material.dart';
import 'package:movie_app/core/common/feature/movie_details/domain/entities/movie_detail.dart';
import 'package:movie_app/core/extensions/media_query_extensions.dart';

import '../../../../../utils/colors.dart';
import 'movie_detail_widget.dart';

class MovieTinyDetailWidget extends StatelessWidget {
  final MovieDetail movie;
  const MovieTinyDetailWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    double scrHeight = context.mediaQueryHeight;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MovieDetailWidget(
          iconData: Icons.calendar_today_outlined,
          detail: movie.releaseDate,
        ),
        _verticalDivider(scrHeight),
        MovieDetailWidget(
          iconData:
              movie.adult ? Icons.explicit : Icons.no_adult_content_outlined,
          detail: movie.adult ? "Adult" : "No Adult",
        ),
        _verticalDivider(scrHeight),
        MovieDetailWidget(
          iconData: Icons.local_movies_sharp,
          detail: movie.genres.first.name,
        ),
      ],
    );
  }

  Widget _verticalDivider(double scrHeight) {
    return SizedBox(
      height: scrHeight * 0.02,
      child: VerticalDivider(
        endIndent: 2,
        indent: 2,
        color: ColorSys.kUnselectedBottomBarIconColor,
      ),
    );
  }
}
