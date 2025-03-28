import 'package:flutter/material.dart';
import 'package:movie_app/core/extensions/media_query_extensions.dart';

class MovieTabbar extends StatelessWidget {
  final TabController tabController;

  const MovieTabbar({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = context.colorScheme;
    return TabBar(
      controller: tabController,

      physics: const NeverScrollableScrollPhysics(),

      dividerHeight: 0,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorPadding: const EdgeInsets.symmetric(horizontal: 15),
      indicatorAnimation: TabIndicatorAnimation.elastic,
      indicatorColor: colorScheme.onSecondary,
      labelColor: colorScheme.onSecondary,
      unselectedLabelColor: colorScheme.onPrimary,
      tabs: [
        const Tab(text: "Upcoming"),
        const Tab(text: "Top Rated"),
        const Tab(text: "Popular"),
      ],
    );
  }
}
