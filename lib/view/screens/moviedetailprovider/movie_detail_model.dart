import 'package:imdbmovie/data/repositories/movie_repository.dart';
import 'package:imdbmovie/di/service_locator.dart';
import 'package:imdbmovie/view/base/base_model.dart';

class MovieDetailModel extends BaseModel {
  final _movieRepository = getIt.get<MovieRepository>();
}
