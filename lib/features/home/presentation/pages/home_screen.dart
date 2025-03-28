import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/common/widget/pagination_loader.dart';
import 'package:movie_app/core/extensions/media_query_extensions.dart';
import 'package:movie_app/core/utils/colors.dart';
import 'package:movie_app/features/bottom_navigation/presentation/bloc/navigation_bloc.dart';
import 'package:movie_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:movie_app/features/home/presentation/widgets/movie_tabbar.dart';
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
    homeBloc = context.read<HomeBloc>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      homeBloc.add(FetchTrendingMovies());
      homeBloc.add(FetchUpcomingMovies());
    });
    _onTabChange();
    super.initState();
  }

  void _onTabChange() {
    _tabController.addListener(() {
      switch (_tabController.index) {
        case 0:
          if (homeBloc.state.upcomingMovie.isEmpty) {
            homeBloc.add(FetchUpcomingMovies());
          }
          break;
        case 1:
          if (homeBloc.state.topratedMovie.isEmpty) {
            homeBloc.add(FetchTopRatedMovies());
          }
          break;
        case 2:
          if (homeBloc.state.popularMovie.isEmpty) {
            homeBloc.add(FetchPopularMovies());
          }
          break;
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
                      context.read<NavigationBloc>().add(
                        const ChangeIndex(index: 1),
                      );
                    },
                    child: Container(
                      width: scrWidth,
                      height: scrHeight * 0.05,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
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
                          const Icon(Icons.search, color: Colors.grey),
                        ],
                      ),
                    ),
                  ),
                  (scrHeight * 0.04).height,
                ],
              ),
            ),
            const TrendingMovieWidget(),
            (scrHeight * 0.04).height,
            MovieTabbar(tabController: _tabController),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      if (state.upcomingMovieLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state.upcomingMovieError != null) {
                        return Center(
                          child: Text(state.upcomingMovieError.toString()),
                        );
                      } else {
                        return NotificationListener(
                          onNotification: (ScrollNotification scrollNoti) {
                            if (scrollNoti.metrics.pixels ==
                                scrollNoti.metrics.maxScrollExtent) {
                              homeBloc.add(FetchUpcomingMovies());
                            }
                            return false;
                          },
                          child: GridView.builder(
                            itemCount:
                                state.upcomingMoviePaginationLoading
                                    ? state.upcomingMovie.length + 1
                                    : state.upcomingMovie.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 9 / 13,
                                ),
                            padding: const EdgeInsets.all(20),
                            itemBuilder: (context, index) {
                              if (state.upcomingMoviePaginationLoading &&
                                  state.upcomingMoviePaginationHasMore) {
                                if (index == state.upcomingMovie.length) {
                                  return const PaginationLoader();
                                }
                              }
                              final movie = state.upcomingMovie.elementAt(
                                index,
                              );
                              return TabbarMovieCard(
                                movie: movie,
                                scrHeight: scrHeight,
                                scrWidth: scrWidth,
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      if (state.topratedMovieLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state.topratedMovieError != null) {
                        return Center(
                          child: Text(state.topratedMovieError.toString()),
                        );
                      } else {
                        return NotificationListener(
                          onNotification: (ScrollNotification scrollNoti) {
                            if (scrollNoti.metrics.pixels ==
                                scrollNoti.metrics.maxScrollExtent) {
                              homeBloc.add(FetchTopRatedMovies());
                            }
                            return false;
                          },
                          child: GridView.builder(
                            itemCount:
                                state.topratedMoviePaginationLoading
                                    ? state.topratedMovie.length + 1
                                    : state.topratedMovie.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 9 / 13,
                                ),
                            padding: const EdgeInsets.all(20),
                            itemBuilder: (context, index) {
                              if (state.topratedMoviePaginationLoading &&
                                  state.topratedMoviePaginationHasMore) {
                                if (index == state.topratedMovie.length) {
                                  return const PaginationLoader();
                                }
                              }
                              final movie = state.topratedMovie.elementAt(
                                index,
                              );
                              return TabbarMovieCard(
                                movie: movie,
                                scrHeight: scrHeight,
                                scrWidth: scrWidth,
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      if (state.popularMovieLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state.popularMovieError != null) {
                        return Center(
                          child: Text(state.popularMovieError.toString()),
                        );
                      } else {
                        return NotificationListener(
                          onNotification: (ScrollNotification scrollNoti) {
                            if (scrollNoti.metrics.pixels ==
                                scrollNoti.metrics.maxScrollExtent) {
                              homeBloc.add(FetchPopularMovies());
                            }
                            return false;
                          },

                          child: GridView.builder(
                            itemCount:
                                state.popularMoviePaginationLoading
                                    ? state.popularMovie.length + 1
                                    : state.popularMovie.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 9 / 13,
                                ),
                            padding: const EdgeInsets.all(20),
                            itemBuilder: (context, index) {
                              if (state.popularMoviePaginationLoading &&
                                  state.popularMoviePaginationHasMore) {
                                if (index == state.popularMovie.length) {
                                  return const PaginationLoader();
                                }
                              }

                              final movie = state.popularMovie.elementAt(index);
                              return TabbarMovieCard(
                                movie: movie,
                                scrHeight: scrHeight,
                                scrWidth: scrWidth,
                              );
                            },
                          ),
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
