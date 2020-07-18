import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdbmovie/data/models/movie.dart';
import 'package:imdbmovie/view/screens/moviedetailprovider/movie_detail_widget.dart';
import 'package:imdbmovie/view/screens/movielistbloc/bloc.dart';
import 'package:imdbmovie/view/screens/movielistbloc/movie_list_bloc.dart';
import 'package:imdbmovie/view/screens/movielistbloc/movie_list_state.dart';
import 'package:imdbmovie/view/widgets/platform_progress.dart';
import 'package:imdbmovie/utils/theme.dart';
import 'package:imdbmovie/utils/utils.dart';

class BlocApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: BlocProvider(
          create: (context) => MovieListBloc()..add(Load()),
          child: MovieList(),
        ),
      ),
    );
  }
}

class MovieList extends StatefulWidget {
  Icon actionIcon = new Icon(Icons.search,color: Colors.white,);
  Widget appBarTitle = new Text(appName);
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  MovieListBloc _movieListBloc;
  
  @override
  void initState() {
    super.initState();
    _movieListBloc = BlocProvider.of<MovieListBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieListBloc, MovieListState>(

      builder: (context, state) {
        if (state is LoadingState) {
          return Center(
            child: PlatformProgress(),
          );
        }

        if (state is LoadErrorState) {
          return Center(
            child: Text(state.message ?? "Failed to load"),
          );
        }

        if (state is LoadSuccessState) {
          return buildList(state.movieList);
        }

        return Container();
      },
    );
  }

  Widget buildList(List<Movie> movieList) {

    return Scaffold(
      appBar: AppBar(
        title: widget.appBarTitle,
        actions: <Widget>[
              new IconButton(
                icon: widget.actionIcon,
                onPressed: () {
                  setState(() {
                    if (widget.actionIcon.icon == Icons.search) {
                      widget.actionIcon = new Icon(Icons.close);
                      widget.appBarTitle = new TextField(
                        style: new TextStyle(
                          color: Colors.white,
                        ),
                        decoration: new InputDecoration(
                            prefixIcon:
                                new Icon(Icons.search, color: Colors.white),
                            hintText: "Search...",
                            hintStyle: new TextStyle(color: Colors.white)),
                        onChanged: (value) {
                          //searchMovies(value);
                        },
                      );
                    } else {
                      widget.actionIcon =
                          new Icon(Icons.search); //reset to initial state
                      widget.appBarTitle = new Text(appName);
                      //filteredContacts = widget.contacts;
                    }
                    });
                },
              ),
          ],
      ),
      body: GridView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: movieList.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
        itemBuilder: (BuildContext context, int index) {
          if (index + 3 >= movieList.length) {
            _movieListBloc.add(LoadMore());
          }
          return buildMovieItem(context, movieList[index]);
        },
      ),
    );
  }

  Widget buildMovieItem(BuildContext context, Movie movie) {
    return GestureDetector(
        onTap: () => openDetailPage(context, movie),
        child: Card(
          margin: EdgeInsets.all(8.0),
          child: Column(
            children: [
              FadeInImage.assetNetwork(
                placeholder: 'assets/image/o.png',
                image: getSmallImageUrl(
                    movie.posterPath),
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
                          '${movie.title}',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: movieTitle,
                        ),
                      ),
                      Container(
                        child: Text(
                          '${movie.overview}',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: movieContent,
                        ),
                      ),
                      Container(
                        child: Text(
                          'Release Date : ${movie.releaseDate}',
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
        )

//      Stack(
//        children: <Widget>[
//          SizedBox.expand(
//              child: Image.network(
//            getSmallImageUrl(movie.posterPath),
//            alignment: Alignment.center,
//          )),
//          Align(
//            alignment: Alignment.bottomCenter,
//            child: Container(
//              width: double.infinity,
//              padding: EdgeInsets.all(6),
//              decoration:
//                  BoxDecoration(color: Colors.grey[900].withOpacity(0.5)),
//              child: Text(
//                movie.title,
//                style: TextStyle(color: Colors.white, fontSize: 16),
//                textAlign: TextAlign.center,
//              ),
//            ),
//          )
//        ],
//      ),
        );
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
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}
