import 'package:flutter/material.dart';

import 'package:movie_app/core/extensions/media_query_extensions.dart';
import 'package:movie_app/core/utils/colors.dart';

class MovieDetailTabbar extends StatelessWidget {
  final TabController tabController;
  const MovieDetailTabbar({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = context.textTheme;
    return TabBar(
      controller: tabController,
      dividerHeight: 0,
      labelStyle: textTheme.displaySmall?.copyWith(
        color: Colors.white,
        fontSize: 15,
      ),
      unselectedLabelStyle: textTheme.displaySmall?.copyWith(
        color: Colors.white,
        fontSize: 15,
      ),
      indicatorSize: TabBarIndicatorSize.label,

      indicatorColor: ColorSys.kUnselectedBottomBarIconColor,
      padding: EdgeInsets.zero,
      indicatorAnimation: TabIndicatorAnimation.elastic,
      tabs: [
        const Tab(text: "About Movie"),

        const Tab(text: "Reviews"),

        const Tab(text: "Cast"),
      ],
    );
  }
}
