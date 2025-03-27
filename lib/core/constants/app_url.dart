class AppUrl {
  const AppUrl._();

  static const String baseURL = 'https://api.themoviedb.org/3';
  static const String trendingMovieEND = '/trending/movie';
  static const String topRatedMovieEND = '/movie/top_rated';
  static const String upcomingMovieEND =
      '/movie/upcoming?language=en-US&page=1';
  static const String popularMovieEND = '/movie/popular';
}
