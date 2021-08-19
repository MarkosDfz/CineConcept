
import 'dart:convert';
import 'package:cineapp/src/models/actores_model.dart';
import 'package:cineapp/src/models/generos_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:cineapp/src/models/pelicula_model.dart';

class PeliculasService with ChangeNotifier {

  Pelicula _pelicula;
  int _currentImage          = 0;
  List<Genero> _generos      = [];
  List<Actor> _actores       = [];
  bool _isSelectedChip       = false;
  String _languaje           = 'es-ES';
  String _horaSeleccionada   = '17:30';
  List<Pelicula> _nowPlaying = new List();
  String _optSelectDate      = 'Junio 07 ';
  String _urlApi             = 'api.themoviedb.org';
  String _apikey             = '';
  List<String> _dateDropdown = [ 'Junio 07 ', 'Junio 08 ', 'Junio 09 ', ];
  List<String> _hora         = [ '17:30', '18:00', '18:30', '19:00', '19:30', '20:00', '20:30', ];
  AnimationController _animationController;

  PeliculasService() {
    this.getNowPlayingList();
    this.getGenerosList();
  }

  // Getters
  List<String> get hora         => this._hora;
  List<Genero> get genero       => this._generos;
  List<Actor> get actores       => this._actores;
  Pelicula get pelicula         => this._pelicula;
  String get optSelectFecha     => _optSelectDate;
  List<Pelicula> get nowPlaying => this._nowPlaying;
  String get horaSeleccionada   => _horaSeleccionada;
  int get currentImage          => this._currentImage;
  bool get isSelectedChip      => this._isSelectedChip;
  AnimationController get animationController => this._animationController;

  // Setters 
  set horaSeleccionada( String value ) {
    this._horaSeleccionada = value;
    notifyListeners();
  }

  set isSelectedChip( bool valor ) {
    this._isSelectedChip = valor;
    notifyListeners();
  }

  set hora( List<String> value ) {
    this._hora = value;
    notifyListeners();
  }

  set optSelectFecha( String fecha) {
    this._optSelectDate = fecha;
    notifyListeners();
  }

  set actores( List<Actor> cast ) {
    this._actores = cast;
    notifyListeners();
  }

  set pelicula( Pelicula peli ) {
    this._pelicula = peli;
    notifyListeners();
  }

  set genero( List<Genero> generos ) {
    this._generos = generos;
    notifyListeners();
  }

  set animationController( AnimationController ctrl ) {
    this._animationController = ctrl;
  }

  set currentImage( int pagina) {
    this._currentImage = pagina;
    notifyListeners();
  }
  
  set nowPlaying( List<Pelicula> peliculas ) {
    this._nowPlaying = peliculas;
    notifyListeners();
  }

  //Functions
  getNowPlayingList() async {

    final url = Uri.https(_urlApi, '3/movie/upcoming', {
      'api_key'  : _apikey,
      'language' : _languaje
    });

    final resp = await http.get(url);
    
    final decodeData = json.decode(resp.body);

    final peliculas = new Peliculas.fromJsonList(decodeData['results']);
   
    this._nowPlaying.addAll(peliculas.items);

    notifyListeners();

  }

  getGenerosList() async {

    final url = Uri.https(_urlApi, '3/genre/movie/list', {
      'api_key'  : _apikey,
      'language' : _languaje
    });

    final resp = await http.get( url );

    final generosResponse = generosFromJson( resp.body );

    this._generos = generosResponse.genres;

  }

  getActoresList( String peliId ) async {

    final url = Uri.https(_urlApi, '3/movie/$peliId/credits', {
      'api_key'  : _apikey,
      'language' : _languaje
    });

    final resp = await http.get( url );

    final decodeData = json.decode(resp.body);

    final actoresResponse = new Cast.fromJsonList(decodeData['cast']);

    this._actores = actoresResponse.actores;

    notifyListeners();

  }

  getGeneroNombre( List<int> nume ) {

    List<Genero> genero = new List();

    for (var item in nume) {

      genero.add( _generos.firstWhere((g) => g.id == item ));
      
    }
    
    return genero;

  }

  List<DropdownMenuItem<String>> getFechaDropdown() {

    List<DropdownMenuItem<String>> lista = new List();

    _dateDropdown.forEach( ( fecha ) {
      lista.add(
        DropdownMenuItem(
          child: Text( fecha ),
          value: fecha,
          onTap: () {},
        )
      );
    });

    return lista;
    
  }

}