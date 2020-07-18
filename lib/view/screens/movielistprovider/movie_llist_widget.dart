import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:imdbmovie/data/models/movie.dart';
import 'package:imdbmovie/data/repositories/movie_repository.dart';
import 'package:imdbmovie/di/service_locator.dart';
import 'package:imdbmovie/view/screens/moviedetailprovider/movie_detail_widget.dart';
import 'package:imdbmovie/view/widgets/platform_progress.dart';
import 'package:imdbmovie/utils/theme.dart';
import 'package:imdbmovie/utils/utils.dart';
import 'package:provider/provider.dart';

import 'movie_list_model.dart';

/// build MovieListWidget with ChangeNotifierProvider
Widget buildMovieListProvider() {
  return ChangeNotifierProvider<MovieListModel>(
    create: (context) => MovieListModel(),
    child: MovieListWidget(),
  );
}

class MovieListWidget extends StatelessWidget {
  MovieListModel movieListModel;
  var listItem = <Movie>[];
  GlobalKey<ScaffoldState> scaffoldKey;
  var currentPage = 0;
  var isLoading = false;
  var isLastPage = false;

  @override
  Widget build(BuildContext context) {
    movieListModel = Provider.of<MovieListModel>(context);
    movieListModel.firstLoad();
    return buildList(movieListModel.itemList);
  }

  Widget buildList(List<Movie> movieList) {
    if (movieListModel.isLoading) {
      return Center(child: PlatformProgress());
    } else {
      return Column(
        children: <Widget>[
          Expanded(
            child: RefreshIndicator(
                onRefresh: movieListModel.onRefreshListener,
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: movieList.length,
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.all(0),
                    shrinkWrap: true,
                    itemBuilder: (context, position) {
                      return Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10, bottom: 5, top: 5),
                          child: InkWell(
                            onTap: () =>
                                openDetailPage(context, movieList[position]),
                            child: Card(
                              elevation: 5,
                              child: Container(
                                child: Row(
                                  children: <Widget>[
                                    FadeInImage.assetNetwork(
                                      height: 150,
                                      placeholder: 'assets/image/o.png',
                                      image: getSmallImageUrl(
                                          movieList[position].posterPath),
                                      fit: BoxFit.cover,
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Container(
                                              child: Text(
                                                '${movieList[position].title}',
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: movieTitle,
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                '${movieList[position].overview}',
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: movieContent,
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                'Release Date : ${movieList[position].releaseDate}',
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: dateTime,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ));
                    })),
          ),
          if (movieListModel.isLoadMore) PlatformProgress()
        ],
      );
    }
  }

  
}
/// open detail page
void openDetailPage(BuildContext context, Movie movie) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) {
      return buildMovieDetailWidget(movie);
    }),
  );
}
const ITEM_PER_PAGE = 20;

class NowMovieListWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const NowMovieListWidget({Key key, this.scaffoldKey}) : super(key: key);

  @override
  _NowMovieListWidgetState createState() {
    return _NowMovieListWidgetState();
  }
}

class _NowMovieListWidgetState extends State<NowMovieListWidget> {
  final movieRepository = getIt.get<MovieRepository>();
  var listItem = <Movie>[];
  GlobalKey<ScaffoldState> scaffoldKey;
  var currentPage = 0;
  var isLoading = false;
  var isLastPage = false;

  @override
  void initState() {
    super.initState();
    scaffoldKey = widget.scaffoldKey;
    firstLoad();
  }

  isFirst() {
    return currentPage == 0 && listItem.isEmpty;
  }

  firstLoad() {
    if (isFirst()) {
      isLoading = true;
      loadData(currentPage + 1);
    }
  }

  loadData(int page) {
    Stream.fromFuture(movieRepository.nowPlayingMovies(page))
//        .doOnListen(onListen)
        .listen((response) => onSuccess(page, response.results),
            onError: onError);
  }

  getItemPerPage() {
    return ITEM_PER_PAGE;
  }

  onSuccess(int page, List<Movie> movies) {
    setState(() {
      currentPage = page;
      if (currentPage == 1) {
        listItem.clear();
        isLastPage = false;
      }

      listItem.addAll(movies);
      isLastPage = movies.length < getItemPerPage();

      isLoading = false;
    });
  }

  onError(e) {
    setState(() {
      isLoading = false;
      scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
    });
  }

  onListen() {
    setState(() {});
  }

  Future<bool> loadMore() async {
    await Future.delayed(Duration(seconds: 0, milliseconds: 100));
    if (isLoading = true) return false;
    isLoading = true;
    loadData(currentPage + 1);
    return true;
  }

  Future<void> refresh() async {
    loadData(1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: RefreshIndicator(
            child: GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: listItem.length,
              itemBuilder: (context, index) =>
                  NowPlayingMovieWidget(movie: listItem[index]),
            ),
            onRefresh: refresh));
  }
}

class NowPlayingMovieWidget extends StatefulWidget {
  final Movie movie;

  NowPlayingMovieWidget({Key key, @required this.movie}) : super(key: key);

  @override
  _NowPlayingMovieWidgetState createState() {
    return _NowPlayingMovieWidgetState();
  }
}

class _NowPlayingMovieWidgetState extends State<NowPlayingMovieWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
        padding: const EdgeInsets.only(
            left: 10.0, right: 10, bottom: 5, top: 5),
        child: InkWell(
          onTap: () =>
              openDetailPage(context,widget.movie),
          child: Card(
            elevation: 5,
            child: Container(
              child: Row(
                children: <Widget>[
                  FadeInImage.assetNetwork(
                    height: 150,
                    placeholder: 'assets/image/o.png',
                    image: getSmallImageUrl(
                        widget.movie.posterPath),
                    fit: BoxFit.cover,
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            child: Text(
                              '${widget.movie.title}',
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: movieTitle,
                            ),
                          ),
                          Container(
                            child: Text(
                              '${widget.movie.overview}',
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: movieContent,
                            ),
                          ),
                          Container(
                            child: Text(
                              'Release Date : ${widget.movie.releaseDate}',
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: dateTime,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));;
  }
}
