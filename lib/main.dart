import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imdbmovie/view/screens/movielistbloc/movie_list.dart';
import 'package:imdbmovie/view/screens/movielistprovider/movie_llist_widget.dart';
import 'package:imdbmovie/utils/theme.dart';

import 'di/service_locator.dart';

void main() {
  setupDI();
  // run app
  runApp(BlocApp());
}



class MainApp extends StatefulWidget {
  MainApp({Key key}) : super(key: key);

  @override
  _MainAppState createState() {
    return _MainAppState();
  }
}

class _MainAppState extends State<MainApp> {

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

