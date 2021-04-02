import 'package:flutter/material.dart';
import 'package:movie_recommender/src/home/search.dart';
import 'package:movie_recommender/src/home/ui/widgets/movies_action.dart';
import 'package:movie_recommender/src/home/ui/widgets/movies_adventure.dart';
import 'package:movie_recommender/src/home/ui/widgets/movies_animation.dart';
import 'package:movie_recommender/src/home/ui/widgets/movies_comedy.dart';
import 'package:movie_recommender/src/home/ui/widgets/movies_crime.dart';
import 'package:movie_recommender/src/home/ui/widgets/movies_drama.dart';
import 'package:movie_recommender/src/home/ui/widgets/movies_fantasy.dart';
import 'package:movie_recommender/src/home/ui/widgets/movies_horror.dart';
import 'package:movie_recommender/src/home/ui/widgets/movies_science.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 9, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Movie Recommender',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              IconButton(
                  icon: Icon(Icons.search, color: Colors.black),
                  onPressed: () async {
                    await showSearch(context: context, delegate: Search());
                  })
            ],
            bottom: _tabbar(_tabController),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            MoviesAction(),
            MoviesAdventure(),
            MoviesFantasy(),
            MoviesCrime(),
            MoviesScience(),
            MoviesAnimation(),
            MoviesDrama(),
            MoviesHorror(),
            MoviesComedy()
          ],
        )
        // Column(
        //   children: [
        //     SizedBox(
        //       height: 10,
        //     ),
        //     GestureDetector(
        //       onTap: () async {
        //         final countrySeleccionado =
        //             await showSearch(context: context, delegate: Search());

        //         print(countrySeleccionado);
        //       },
        //       child: Container(
        //         margin: EdgeInsets.only(left: 15, right: 15),
        //         padding:
        //             EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
        //         decoration: BoxDecoration(
        //             color: Colors.white,
        //             borderRadius: BorderRadius.circular(5),
        //             border: Border.all(
        //                 width: 2, color: Colors.purple.withOpacity(0.5))),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Text(
        //               'Ingresa una pelicula que te guste',
        //               style: TextStyle(fontSize: 20),
        //             ),
        //             SizedBox(
        //               width: 10,
        //             ),
        //             Icon(Icons.search_outlined),
        //           ],
        //         ),
        //       ),
        //     ),
        //     SizedBox(
        //       height: 20,
        //     ),
        //     Text(
        //       'Escoge una categoria',
        //       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        //     ),
        //     Genres(),
        //   ],
        // ),
        );
  }

  Widget _tabbar(controller) {
    return PreferredSize(
      preferredSize: Size.fromHeight(0),
      child: Column(
        children: [
          TabBar(
            isScrollable: true,
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.purple,
            tabs: [
              Tab(
                text: "Acción",
              ),
              Tab(
                text: "Aventura",
              ),
              Tab(
                text: "Fantasia",
              ),
              Tab(
                text: "Crimen",
              ),
              Tab(
                text: "Ciencia Ficción",
              ),
              Tab(
                text: "Animación",
              ),
              Tab(
                text: "Drama",
              ),
              Tab(
                text: "Horror",
              ),
              Tab(
                text: "Comedia",
              ),
            ],
            controller: _tabController,
            indicatorColor: Colors.purple,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
        ],
      ),
    );
  }
}
