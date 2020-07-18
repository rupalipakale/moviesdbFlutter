import 'package:get_it/get_it.dart';
import 'package:imdbmovie/data/repositories/movie_repository.dart';

final getIt = GetIt.instance;

void setupDI() async {
  getIt.registerLazySingleton<MovieRepository>(
      () => MovieRepository.getInstance());
}
