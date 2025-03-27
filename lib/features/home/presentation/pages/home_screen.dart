import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/extensions/media_query_extensions.dart';
import 'package:movie_app/core/utils/colors.dart';
import 'package:movie_app/features/home/presentation/widgets/tabbar_movie_card.dart';
import 'package:movie_app/features/home/presentation/widgets/trending_movie_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double scrHeight = context.mediaQueryHeight;
    double scrWidth = context.mediaQueryWidth;
    TextTheme textTheme = context.textTheme;
    ColorScheme colorScheme = context.colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  Text(
                    "What do you want to watch?",
                    style: textTheme.bodyMedium,
                  ),
                  (scrHeight * 0.02).height,
                  Container(
                    width: scrWidth,
                    height: scrHeight * 0.05,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: ColorSys.kUnselectedBottomBarIconColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        Text(
                          "Search",
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                        ),
                        Icon(Icons.search, color: Colors.grey),
                      ],
                    ),
                  ),
                  (scrHeight * 0.04).height,
                ],
              ),
            ),
            TrendingMovieWidget(),
            (scrHeight * 0.04).height,
            TabBar(
              controller: _tabController,
              dividerHeight: 0,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: EdgeInsets.symmetric(horizontal: 15),
              indicatorAnimation: TabIndicatorAnimation.elastic,
              indicatorColor: colorScheme.onSecondary,
              labelColor: colorScheme.onSecondary,
              unselectedLabelColor: colorScheme.onPrimary,
              tabs: [
                Tab(text: "Upcoming"),
                Tab(text: "Top Rated"),
                Tab(text: "Popular"),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 9 / 13,
                    ),
                    padding: EdgeInsets.all(20),
                    itemBuilder:
                        (context, index) => TabbarMovieCard(
                          scrHeight: scrHeight,
                          scrWidth: scrWidth,
                        ),
                  ),
                  Container(),
                  Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
