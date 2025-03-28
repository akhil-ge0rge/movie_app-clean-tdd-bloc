import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/bottom_navigation/presentation/bloc/navigation_bloc.dart';
import 'package:movie_app/features/favourite/presentation/pages/favourite.dart';
import 'package:movie_app/features/home/presentation/pages/home_screen.dart';
import 'package:movie_app/features/search/presentation/pages/search_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  final List<Widget> _screens = [const HomePage(), const SearchScreen(), const FavouriteScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          return _screens[state.index];
        },
      ),
      bottomNavigationBar: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: state.index,
            onTap: (value) {
              context.read<NavigationBloc>().add(ChangeIndex(index: value));
            },
            items: [
              const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              const BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorite',
              ),
            ],
          );
        },
      ),
    );
  }
}
