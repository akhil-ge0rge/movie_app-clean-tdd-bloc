import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/common/feature/movie_details/presentation/bloc/movie_details_bloc.dart';
import 'package:movie_app/core/common/feature/movie_details/presentation/widgets/movie_detail_tabbar.dart';
import 'package:movie_app/core/common/feature/movie_details/presentation/widgets/movie_detail_top_section.dart';
import 'package:movie_app/core/common/feature/movie_details/presentation/widgets/movie_tiny_detail_widget.dart';
import 'package:movie_app/core/common/feature/movie_details/presentation/widgets/review_list_widget.dart';
import 'package:movie_app/core/extensions/media_query_extensions.dart';

import '../widgets/about_widget.dart';
import '../widgets/cast_widget.dart';
import '../widgets/movie_poster_and_name_widget.dart';

class MovieDetailPage extends StatefulWidget {
  final int movieId;
  const MovieDetailPage({super.key, required this.movieId});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late MovieDetailsBloc bloc;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    bloc = context.read<MovieDetailsBloc>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc.add(FetchMovieDetailById(movieId: widget.movieId));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double scrHeight = context.mediaQueryHeight;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.bookmark)),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MovieDetailTopSection(),
            SizedBox(height: scrHeight * 0.02),
            MovieDetailTabbar(tabController: _tabController),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  const AboutWidget(),
                  const ReviewListWidget(),
                  const CastWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
