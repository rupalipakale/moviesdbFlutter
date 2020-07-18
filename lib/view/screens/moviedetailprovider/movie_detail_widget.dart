import 'package:flutter/material.dart';
import 'package:imdbmovie/data/models/movie.dart';
import 'package:imdbmovie/utils/theme.dart';
import 'package:imdbmovie/utils/utils.dart';
import 'package:provider/provider.dart';

import 'movie_detail_model.dart';

/// build MovieListWidget with ChangeNotifierProvider
Widget buildMovieDetailWidget(Movie movie) {
  return ChangeNotifierProvider<MovieDetailModel>(
    create: (context) => MovieDetailModel(),
    child: MovieDetailWidget(movie),
  );
}

class MovieDetailWidget extends StatelessWidget {
  final Movie movie;
  final imagePosterTag = 'image-poster';

  MovieDetailWidget(this.movie);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text("Movie Detail"),
      ),
      body: ListView(
        children: <Widget>[
          GestureDetector(
            child: Container(
              height: 200,
              child: Hero(
                tag: imagePosterTag,
                child: Image.network(
                  getLargeImageUrl(movie.posterPath),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Scaffold(
                        body: Center(
                          child: Hero(
                              tag: imagePosterTag,
                              child: Image.network(
                                  getLargeImageUrl(movie.posterPath))),
                        ),
                      )));
            },
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  movie.title,
                  style: movieBigTitle,
                ),
                Container(margin: EdgeInsets.only(top: 16)),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 2),
                    ),
                    Text(
                      movie.voteAverage.toString(),
                      style: movieSmallTitle,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                    ),
                    Text(
                      'Release Date : ${movie.releaseDate}',
                      style: movieSmallTitle,
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
                Container(margin: EdgeInsets.only(top: 16)),
                Text(
                  movie.overview,
                  style: movieContent,
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
