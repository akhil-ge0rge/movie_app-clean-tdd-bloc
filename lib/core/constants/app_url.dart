class AppUrl {
  const AppUrl._();

  static const String baseURL = 'https://api.themoviedb.org/3';
  static const String trendingMovieEND = '/trending/movie/day';
  static const String topRatedMovieEND = '/movie/top_rated';
  static const String upcomingMovieEND =
      '/movie/upcoming?language=en-US&page=1';
  static const String popularMovieEND = '/movie/popular';
  static const String movieDetailsEND = '/movie';

  static const String imageBaseURL = "https://image.tmdb.org/t/p/w500";
  static const String brokenImageURL =
      "https://upload.wikimedia.org/wikipedia/commons/a/a3/Image-not-found.png";
}
