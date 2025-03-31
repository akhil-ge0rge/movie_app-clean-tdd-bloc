import 'package:flutter/material.dart';

import 'package:movie_app/core/extensions/media_query_extensions.dart';
import 'package:movie_app/core/utils/colors.dart';

class MovieDetailWidget extends StatelessWidget {
  final IconData iconData;
  final String detail;
  const MovieDetailWidget({
    super.key,
    required this.iconData,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = context.colorScheme;
    TextTheme textTheme = context.textTheme;
    return Row(
      spacing: 5,
      children: [
        Icon(iconData, size: 12, color: ColorSys.kUnselectedBottomBarIconColor),
        Text(
          detail,
          style: textTheme.bodySmall?.copyWith(
            fontSize: 13,
            color: ColorSys.kUnselectedBottomBarIconColor,
          ),
        ),
      ],
    );
  }
}
