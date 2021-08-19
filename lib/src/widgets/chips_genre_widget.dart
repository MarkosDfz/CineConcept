
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:cineapp/src/models/generos_model.dart';
import 'package:cineapp/src/services/pelicula_service.dart';

class ChipsGenreWidget extends StatelessWidget {

  final List<int> generoList;

  ChipsGenreWidget( { @required this.generoList } );

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

    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric( horizontal: 15 ),
        child: ListView(
          children: list,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }

}