
import 'dart:ui';
import 'package:cineapp/src/widgets/chips_genre_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:cineapp/src/widgets/rating_widget.dart';
import 'package:cineapp/src/models/pelicula_model.dart';
import 'package:cineapp/src/services/pelicula_service.dart';

class PeliculasPage extends StatelessWidget {

  @override
  Widget build( BuildContext context ) {

    final _size = MediaQuery.of(context).size;
    final movieService = Provider.of<PeliculasService>(context);
    List<Pelicula> pelicula = movieService.nowPlaying;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Background(),
          Positioned(
            top: _size.height * 0.6 ,
            width: _size.width,
            height: 200,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                child: Container(
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            )
          ),
          Center(
            child: ( pelicula.length == 0 )
            ? Center( child: CircularProgressIndicator() )
            : Container(
              width: _size.width,
              height: _size.height * 0.76,
              child: Swiper(
                scale: 0.75,
                fade: 0.6,
                viewportFraction: 0.7,
                itemCount: pelicula.length,
                itemBuilder: ( BuildContext context, int i ) {
                  return GestureDetector(
                    child: Container(
                      padding: EdgeInsets.only( top: 80 ),
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular( 50.0 )
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric( vertical: 30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image(
                                  height: 330,
                                  // width: 100,
                                  image: NetworkImage( movieService.nowPlaying[i].getPosterImg() )
                                ),
                              ),
                              SizedBox( height: 30.0 ),
                              Padding(
                                padding: EdgeInsets.symmetric( horizontal: 20.0),
                                child: Text( movieService.nowPlaying[i].title,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24.0, 
                                    fontWeight: FontWeight.bold
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              ChipsGenreWidget(
                                generoList: movieService.nowPlaying[i].genreIds
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text( '${ movieService.nowPlaying[i].voteAverage }',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                    )
                                  ),
                                  SizedBox( width: 5.0 ),
                                  RankingWidget(
                                    ratingValue: movieService.nowPlaying[i].voteAverage,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      movieService.pelicula = movieService.nowPlaying[i];
                      movieService.getActoresList(movieService.nowPlaying[i].id.toString());
                      Navigator.pushNamed(context, 'detalle');
                    },
                  );
                },
                onIndexChanged: (i) {
                  movieService.currentImage = i;
                  if ( i > 0 ) {
                    final ctrl = movieService.animationController;
                    ctrl.forward( from: 0.0 );
                  }
                },
              )
            ),
          ),
          Positioned(
            top: _size.height * 0.91,
            width: _size.width * 0.7,
            left: _size.width * 0.16,
            child: Container(
              height: 52,
              child: Center(
                child: Text( 'COMPRAR TICKET',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular( 10.0 )
              ),
            ),
          )
        ],
      ),
    );

  }

}

class Background extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final _size = MediaQuery.of(context).size;
    final movieService = Provider.of<PeliculasService>(context);
    final i = movieService.currentImage;

    return
    ( movieService.nowPlaying.length == 0 ) ?
    Container() :
    FadeIn(
      duration: Duration( milliseconds: 600 ),
      controller: (controller) => movieService.animationController = controller,
      child: Container(
        height: _size.height * 0.7,
        child: Image(
          fit: BoxFit.cover,
          image: NetworkImage( movieService.nowPlaying[i].getPosterImg() )
        ),
      ),
    );
  }
}

