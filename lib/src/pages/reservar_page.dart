
import 'dart:math' as math;
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:cineapp/src/pages/detalle_page.dart';
import 'package:cineapp/src/services/pelicula_service.dart';

class ReservarPage extends StatefulWidget {

  static Matrix4 _pmat(num pv) {
    
    return new Matrix4(
      1.0, 0.0, 0.0, 0.0, //
      0.0, 1.0, 0.0, 0.0, //
      0.0, 0.0, 1.0, pv * 0.001, //
      0.0, 0.0, 0.0, 1.0,
    );
  }

  @override
  _ReservarPageState createState() => _ReservarPageState();
}

class _ReservarPageState extends State<ReservarPage> {

  Matrix4 perspective = ReservarPage._pmat(1.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Todo(),
          ImagenMovie( perspective ),
          Back(),
          AsientosContainer(),
          ButtonPagarTicket(),
        ],
      )
   );
  }
}

class DateContainer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final _size = MediaQuery.of(context).size;

    return Container(
      width: _size.width,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            child: _crearDropdownFecha( context )
          ),
          HorasChip()
        ],
      ),
    );
  }

}

Widget _crearDropdownFecha( BuildContext context ) {

  final movieService = Provider.of<PeliculasService>(context);

  return DropdownButton(
    dropdownColor: Colors.black,
    isDense: true,
    iconSize: 25.0,
    underline: Container(),
    style: TextStyle(
      fontSize: 20,
      color: Colors.white,
    ),
    icon: Icon( Icons.arrow_drop_down, color: Colors.white, ),
    value: movieService.optSelectFecha,
    items: movieService.getFechaDropdown(),
    onChanged: (opt) {
      movieService.optSelectFecha = opt;
    }
  );

}

class HorasChip extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    List<Widget> list = new List<Widget>();
    final movieService = Provider.of<PeliculasService>(context);

    for(var i = 0; i < movieService.hora.length; i++){

      list.add(
        Container(
          padding: EdgeInsets.symmetric( horizontal: 2.0 ),
          child: GestureDetector(
            child: Chip(
              backgroundColor: ( movieService.horaSeleccionada == movieService.hora[i] ) ? Colors.red : Colors.black,
              shape: RoundedRectangleBorder( borderRadius: BorderRadius.all( Radius.circular( 5 ) ) ),
              label: Text( movieService.hora[i],
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white
                ),
              )
            ),
            onTap: () {
              movieService.horaSeleccionada = movieService.hora[i];
            },
          ),
        )
      );
    }

    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
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

class AsientosContainer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final _size = MediaQuery.of(context).size;

    return Positioned(
      bottom: 0,
      width: _size.width,
      child: Container(
        width: _size.width,
        height: _size.height * 0.7,
        child: Column(
          children: <Widget>[
            Container(
              height: 330,
              width: _size.width,
              child: Container(
                padding: EdgeInsets.all(10),
                child: GrupoAsientos()
              ),
            ),
            SizedBox( height: 10 ),
            FadeInUp(
              duration: Duration( milliseconds: 900 ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      _asiento(
                        status: 0
                      ),
                      SizedBox( width: 6 ),
                      Text('Apartado', style: TextStyle( color: Colors.white ),)
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      _asiento(
                        status: 1
                      ),
                      SizedBox( width: 6 ),
                      Text('Disponible', style: TextStyle( color: Colors.white ),)
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      _asiento(
                        status: 2
                      ),
                      SizedBox( width: 6 ),
                      Text('Seleccionado', style: TextStyle( color: Colors.white ),)
                    ],
                  )
                ],
              ),
            ),
            SizedBox( height: 20 ),
            FadeInUp(
              duration: Duration( milliseconds: 900 ),
              child: DateContainer()
            )
          ],
        ),
      ),
    );
  }
  
}

class GrupoAsientos extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      duration: Duration( milliseconds: 900 ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  _asiento(),
                  _asiento(
                    status: 1
                  ),
                  _asiento(
                    status: 1
                  ),
                  _asiento(),
                ],
              ),
              Row(
                children: <Widget>[
                  _asiento(),
                  _asiento(),
                  _asiento(),
                  _asiento(
                    status: 1
                  ),
                  _asiento(),
                  _asiento(),
                ],
              ),
              Row(
                children: <Widget>[
                  _asiento(),
                  _asiento(),
                  _asiento(),
                  _asiento(),
                  _asiento(),
                  _asiento(),
                  _asiento(),
                  _asiento(),
                ],
              ),
              Row(
                children: <Widget>[
                  _asiento(),
                  _asiento(),
                  _asiento(
                    status: 1
                  ),
                  _asiento(),
                  _asiento(
                    status: 1
                  ),
                  _asiento(),
                  _asiento(),
                  _asiento(),
                ],
              ),
              Row(
                children: <Widget>[
                  _asiento(),
                  _asiento(),
                  _asiento(),
                  _asiento(),
                  _asiento(
                    status: 1
                  ),
                  _asiento(
                    status: 1
                  ),
                  _asiento(),
                  _asiento(),
                ],
              ),
              Row(
                children: <Widget>[
                  _asiento(),
                  _asiento(
                    status: 1
                  ),
                  _asiento(),
                  _asiento(
                    status: 1
                  ),
                  _asiento(),
                  _asiento(
                    status: 1
                  ),
                  _asiento(),
                  _asiento(),
                ],
              ),
              Row(
                children: <Widget>[
                  _asiento(),
                  _asiento(),
                  _asiento(),
                  _asiento(),
                  _asiento(),
                  _asiento(
                    status: 1
                  ),
                  _asiento(
                    status: 1
                  ),
                  _asiento(
                    status: 1
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  _asiento(),
                  _asiento(),
                  _asiento(),
                  _asiento(),
                  _asiento(),
                  _asiento(),
                  _asiento(),
                  _asiento(),
                ],
              ),
            ],
          ),
          SizedBox( width: 20 ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox( height: 50 ),
              _asiento(),
              _asiento(),
              _asiento(),
              _asiento(),
              _asiento(),
              _asiento(
                status: 1
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox( height: 50 ),
              _asiento(),
              _asiento(),
              _asiento(),
              _asiento(),
              _asiento(),
              _asiento(
                status: 1
              ),
            ],
          )
        ],
      ),
    );
  }
}

Widget _asiento( { int status = 0 } ) {

  Color _color;
  switch (status) {
    case 0:
      _color = Color(0xff5B575D);
      break;
    case 1:
      _color = Color(0xffF1B876);
      break;
    case 2:
      _color = Colors.red;
      break;
    default:
      _color = Color(0xff5B575D);
  }

  return Container(
    padding: EdgeInsets.all(3),
    child: Icon(
      Icons.weekend,
      size: 30,
      color: _color,
    ),
  );

}

class ImagenMovie extends StatelessWidget {

  final Matrix4 perspective;

  ImagenMovie( this.perspective );

  @override
  Widget build(BuildContext context) {

    final _size = MediaQuery.of(context).size;
    final movieService = Provider.of<PeliculasService>(context);

    return SafeArea(
      child: Container(
        padding: EdgeInsets.only( top: 30, left: 10, right: 10 ),
        width: _size.width * 8,
        child: Transform(
          child: ZoomIn(
            duration: Duration( milliseconds: 2100 ),
            child: Image(
              height: _size.height * 0.22,
              image: NetworkImage( movieService.pelicula.getBackgroundImg() )
            ),
          ),
          alignment: FractionalOffset.center,
          transform: perspective.scaled(1.0, 1.0, 1.0)
          ..rotateX( math.pi - 128 * math.pi / 180 )
          ..rotateY(0.0)
          ..rotateZ(0.0)
        ),
      ),
    );
  }

}

class Back extends StatelessWidget {
  
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

class ButtonPagarTicket extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final _size = MediaQuery.of(context).size;
    
    return Positioned(
      top: _size.height * 0.91 ,
      width: _size.width * 0.7,
      left: _size.width * 0.16,
      child: GestureDetector(
        child: FadeInUp(
          child: Container(
            height: 52,
            child: Center(
              child: Text( 'PAGAR TICKET',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular( 10.0 )
            ),
          ),
        ),
        onTap: () {
          Navigator.pushNamed(context, 'reservar');
        },
      ),
    );
  }
  
}