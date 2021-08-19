
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:cineapp/src/models/generos_model.dart';
import 'package:cineapp/src/models/pelicula_model.dart';
import 'package:cineapp/src/services/pelicula_service.dart';
import 'package:cineapp/src/widgets/rating_widget.dart';

class DetallePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Todo(),
          BounceInUp(
            duration: Duration( milliseconds: 1500 ),
            child: BackgroundSlider()
          ),
          BackButton(),
          DetailContainer(),
          ButtonTicket()
        ],
      ),
   );
  }
}

class DetailContainer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final _size = MediaQuery.of(context).size;
    final movieService = Provider.of<PeliculasService>(context);

    return Positioned(
      bottom: 0,
      width: _size.width,
      child: Container(
        width: _size.width,
        height: _size.height * 0.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          )
        ),
        child: Column(
          children: <Widget>[
            SizedBox( height: 20 ),
            Container(
              padding: EdgeInsets.symmetric( horizontal: 30 ),
              child: FadeInUp(
                duration: Duration( milliseconds: 900 ),
                child: Text( movieService.pelicula.title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric( horizontal: 30 ),
              child: FadeInUp(
                duration: Duration( milliseconds: 900 ),
                child: GenerosChip( 
                  generoList: movieService.pelicula.genreIds,
                ),
              ),
            ),
            FadeInUp(
              duration: Duration( milliseconds: 900 ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text( '${ movieService.pelicula.voteAverage }',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                    )
                  ),
                  SizedBox( width: 5.0 ),
                  RankingWidget(
                    ratingValue: movieService.pelicula.voteAverage,
                  )
                ],
              ),
            ),
            SizedBox( height: 14 ),
            Container(
              padding: EdgeInsets.only( left: 30 ),
              alignment: Alignment.centerLeft,
              child: FadeInUp(
                duration: Duration( milliseconds: 900 ),
                child: Text( 'Actores',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            FadeInUp(
              duration: Duration( milliseconds: 900 ),
              child: ActoresSwiper()
            ),
            Container(
              padding: EdgeInsets.only( left: 30 ),
              alignment: Alignment.centerLeft,
              child: FadeInUp(
                duration: Duration( milliseconds: 900 ),
                child: Text( 'Sinopsis',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only( left: 30, right: 30, bottom: 30, top: 10 ),
              child: FadeInUp(
                duration: Duration( milliseconds: 900 ),
                child: Text( movieService.pelicula.overview,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black87
                  ),
                  maxLines: 8,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GenerosChip extends StatelessWidget {

  final List<int> generoList;

  GenerosChip( { @required this.generoList } );

  @override
  Widget build(BuildContext context) {
    
    final movieService = Provider.of<PeliculasService>(context);
    List<Genero> genreItem =  movieService.getGeneroNombre( generoList );
    List<Widget> list = new List<Widget>();

    for(var i = 0; i < generoList.length; i++){

      list.add(
        Container(
          padding: EdgeInsets.symmetric( horizontal: 2.0 ),
          child: Chip(
            backgroundColor: Colors.white,
            elevation: 3,
            label: Text( '${ genreItem[i].name }' )
          ),
        )
      );
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      child: Center(
        child: ListView(
          children: list,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );

  }
  
}

class ActoresSwiper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final _size = MediaQuery.of(context).size;
    final movieService = Provider.of<PeliculasService>(context);

    return Container(
      padding: EdgeInsets.only( top: 10 ),
      height: 186,
      width: _size.width,
      child:  ( movieService.actores.length == 0 )
      ? Center( child: CircularProgressIndicator() )
      : Swiper(
        viewportFraction: 0.31,
        itemCount: movieService.actores.length,
        itemBuilder: ( BuildContext context, int i ) {
          return Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image(
                  width: 94,
                  height: 140,
                  fit: BoxFit.cover,
                  image: NetworkImage( movieService.actores[i].getFoto() )
                ),
              ),
              SizedBox( height: 8 ),
              Text( '${ movieService.actores[i].name }',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.0,
                  // fontWeight: FontWeight.bold
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          );
        }
      ),
    );
  }

}

class BackgroundSlider extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    final _size = MediaQuery.of(context).size;
    final movieService = Provider.of<PeliculasService>(context);
    List<Pelicula> pelicula = movieService.nowPlaying;
    final page = movieService.currentImage;

    return SafeArea(
      child: Container(
        padding: EdgeInsets.only( top: 10 ),
        width: _size.width,
        height: _size.height * 0.45,
        child: Swiper(
          index: page,
          fade: 0.7,
          scale: 0.65,
          viewportFraction: 0.6,
          itemCount: pelicula.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: ( BuildContext context, int i ) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image(
                height: 320,
                fit: BoxFit.cover,
                image: NetworkImage( movieService.nowPlaying[i].getPosterImg() )
              ),
            );
          },
        )
      ),
    );
  }
}

class Todo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

  final _size = MediaQuery.of(context).size;

    return Container(
      height: _size.height,
    );
  }
}

class ButtonTicket extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final _size = MediaQuery.of(context).size;
    
    return Positioned(
      top: _size.height * 0.91 ,
      width: _size.width * 0.7,
      left: _size.width * 0.16,
      child: GestureDetector(
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
        onTap: () {
          Navigator.pushNamed(context, 'reservar');
        },
      ),
    );
  }
  
}

class BackButton extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: OutlineButton(
        child: Icon( Icons.close, color: Colors.white, size: 18.0, ),
        shape: CircleBorder(),
        borderSide: BorderSide( width: 2, color: Colors.white30 ),
        highlightedBorderColor: Colors.white30,
        onPressed: () {
            Navigator.pop(context);
        },
      ),
    );

  }
}