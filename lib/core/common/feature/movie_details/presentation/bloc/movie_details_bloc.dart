import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/core/common/feature/movie_details/domain/entities/movie_detail.dart';
import 'package:movie_app/core/common/feature/movie_details/domain/usecase/movie_by_id.dart';

part 'movie_details_event.dart';
part 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final MovieByIdUseCase movieByIdUseCase;
  MovieDetailsBloc({required this.movieByIdUseCase})
    : super(MovieDetailsInitial()) {
    on<FetchMovieDetailById>(_handleFetchMovieById);
  }

  Future<void> _handleFetchMovieById(
    FetchMovieDetailById event,
    Emitter<MovieDetailsState> emit,
  ) async {
    emit(MovieDetailsLoading());
    final result = await movieByIdUseCase(event.movieId);

    result.fold(
      (l) => emit(MovieDetailsError(message: l.message)),
      (r) => emit(MovieDetailsLoaded(movie: r)),
    );
  }
}
