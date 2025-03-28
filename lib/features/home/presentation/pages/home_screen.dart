import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/extensions/media_query_extensions.dart';
import 'package:movie_app/core/utils/colors.dart';
import 'package:movie_app/features/bottom_navigation/presentation/bloc/navigation_bloc.dart';
import 'package:movie_app/features/home/presentation/bloc/home_bloc.dart';
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
  late HomeBloc homeBloc;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      homeBloc = context.read<HomeBloc>();
      homeBloc.add(FetchTrendingMovies());
      homeBloc.add(FetchUpcomingMovies());
    });
    _listedTabControllerIndexChange();
    super.initState();
  }

  void _listedTabControllerIndexChange() {
    _tabController.addListener(() {
      log("Hello");
      int val = _tabController.index;
      if (val == 0) {
        if (context.read<HomeBloc>().state.upcomingMovie.isNotEmpty) return;
        homeBloc.add(FetchUpcomingMovies());
      } else if (val == 1) {
        if (context.read<HomeBloc>().state.topratedMovie.isNotEmpty) return;
        homeBloc.add(FetchTopRatedMovies());
      } else {
        if (context.read<HomeBloc>().state.popularMovie.isNotEmpty) return;
        homeBloc.add(FetchPopularMovies());
      }
    });
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "What do you want to watch?",
                    style: textTheme.bodyMedium,
                  ),
                  (scrHeight * 0.02).height,
                  GestureDetector(
                    onTap: () {
                      context.read<NavigationBloc>().add(ChangeIndex(index: 1));
                    },
                    child: Container(
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
                  ),
                  (scrHeight * 0.04).height,
                ],
              ),
            ),
            TrendingMovieWidget(),
            (scrHeight * 0.04).height,
            TabBar(
              controller: _tabController,

              physics: NeverScrollableScrollPhysics(),

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
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      if (state.upcomingMovieLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state.upcomingMovieError != null) {
                        return Center(
                          child: Text(state.upcomingMovieError.toString()),
                        );
                      } else {
                        return GridView.builder(
                          itemCount: state.upcomingMovie.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: 9 / 13,
                              ),
                          padding: EdgeInsets.all(20),
                          itemBuilder: (context, index) {
                            final movie = state.upcomingMovie.elementAt(index);
                            return TabbarMovieCard(
                              movie: movie,
                              scrHeight: scrHeight,
                              scrWidth: scrWidth,
                            );
                          },
                        );
                      }
                    },
                  ),
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      if (state.topratedMovieLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state.topratedMovieError != null) {
                        return Center(
                          child: Text(state.topratedMovieError.toString()),
                        );
                      } else {
                        return GridView.builder(
                          itemCount: state.topratedMovie.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: 9 / 13,
                              ),
                          padding: EdgeInsets.all(20),
                          itemBuilder: (context, index) {
                            final movie = state.topratedMovie.elementAt(index);
                            return TabbarMovieCard(
                              movie: movie,
                              scrHeight: scrHeight,
                              scrWidth: scrWidth,
                            );
                          },
                        );
                      }
                    },
                  ),
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      if (state.popularMovieLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state.popularMovieError != null) {
                        return Center(
                          child: Text(state.popularMovieError.toString()),
                        );
                      } else {
                        return GridView.builder(
                          itemCount: state.popularMovie.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: 9 / 13,
                              ),
                          padding: EdgeInsets.all(20),
                          itemBuilder: (context, index) {
                            final movie = state.popularMovie.elementAt(index);
                            return TabbarMovieCard(
                              movie: movie,
                              scrHeight: scrHeight,
                              scrWidth: scrWidth,
                            );
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
