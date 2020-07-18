import 'package:imdbmovie/data/models/movie.dart';
import 'package:imdbmovie/data/remote/response/MovieListResponse.dart';
import 'package:imdbmovie/data/repositories/movie_repository.dart';
import 'package:imdbmovie/di/service_locator.dart';
import 'package:imdbmovie/view/base/base_load_more_refresh_model.dart';

class MovieListModel extends BaseLoadMoreRefreshModel<Movie> {

  final _movieRepository = getIt.get<MovieRepository>();

  @override
  void loadData(int page) async {
    _movieRepository
        .nowPlayingMovies(page)
        .then(
          (response) => {
            if (response is MovieListResponse)
              {
                onLoadSuccess(page, response.results),
              }
          },
        )
        .catchError(
          (exception) => {
            if (exception is Exception)
              {
                onLoadFail(exception),
              }
          },
        );
  }
}
