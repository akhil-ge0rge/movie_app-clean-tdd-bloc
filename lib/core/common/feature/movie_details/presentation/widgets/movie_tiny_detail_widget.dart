import 'package:flutter/material.dart';
import 'package:movie_app/core/extensions/media_query_extensions.dart';

import '../../../../../utils/colors.dart';
import 'movie_detail_widget.dart';

class MovieTinyDetailWidget extends StatelessWidget {
  const MovieTinyDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double scrHeight = context.mediaQueryHeight;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MovieDetailWidget(
          iconData: Icons.calendar_today_outlined,
          detail: "2021",
        ),
        _verticalDivider(scrHeight),
        MovieDetailWidget(
          iconData: Icons.access_time_outlined,
          detail: "148 Minutes",
        ),
        _verticalDivider(scrHeight),
        MovieDetailWidget(iconData: Icons.local_movies_sharp, detail: "Action"),
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
