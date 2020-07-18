import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:imdbmovie/data/models/movie.dart';
import 'package:imdbmovie/data/remote/response/MovieListResponse.dart';

abstract class MovieRepository {
  Future<MovieListResponse> nowPlayingMovies(int page);

  Future<MovieListResponse> getMovies(String query);

  Future<Movie> getMovieById(String id);

  factory MovieRepository.getInstance() => _MovieRepository();
}

class _MovieRepository implements MovieRepository {
  static const MOVIE_API_KEY = '458813371460bca443b49ffd48536bd6';
  static const BASE_URL = 'api.themoviedb.org';
  static const NOW_PLAYING = '/3/movie/now_playing';
  static const SEARCH_MOVIE = '/3/search/movie';
  static const MOVIE_DETAIL = '/3/movie/';

  static const API_KEY = 'api_key';
  static const QUERY = 'query';
  static const PAGE = "page";
  static const RESULTS = 'results';
  static const STATUS_MESSAGE = 'status_message';

  static _MovieRepository _instance;
//  final FavoriteMovieDb _db;

  factory _MovieRepository() =>
      _instance ??= _MovieRepository._internal();

  _MovieRepository._internal();

  @override
  Future<MovieListResponse> nowPlayingMovies(int page) async {
    final url = Uri.https(BASE_URL, NOW_PLAYING,
        {API_KEY: MOVIE_API_KEY, PAGE: page.toString()});
    print(url);
    final response = await http.get(url);
    final decoded = json.decode(response.body);

    switch (response.statusCode) {
      case HttpStatus.ok:
        return MovieListResponse.fromJson(decoded);
        break;

      default:
        throw HttpException(decoded[STATUS_MESSAGE]);
    }
  }

  @override
  Future<MovieListResponse> getMovies(String query) async {
    final url = Uri.https(
      BASE_URL,
      SEARCH_MOVIE,
      {API_KEY: MOVIE_API_KEY, QUERY: query ?? ''},
    );
    final response = await http.get(url);
    final decoded = json.decode(response.body);

    // return response.statusCode == HttpStatus.ok
    //     ? (decoded[RESULTS] as List)
    //         .map((json) => Movie.fromJson(json))
    //         .toList()
    //     : throw HttpException(decoded[STATUS_MESSAGE]);
    switch (response.statusCode) {
      case HttpStatus.ok:
        return MovieListResponse.fromJson(decoded);
        break;

      default:
        throw HttpException(decoded[STATUS_MESSAGE]);
    }
  }

  @override
  Future<Movie> getMovieById(String id) async {
    final url = Uri.https(
      BASE_URL,
      MOVIE_DETAIL + '$id',
      {API_KEY: MOVIE_API_KEY},
    );
    final response = await http.get(url);
    final decoded = json.decode(response.body);

    return response.statusCode == HttpStatus.ok
        ? Movie.fromJson(decoded)
        : throw HttpException(decoded[STATUS_MESSAGE]);
  }
}
