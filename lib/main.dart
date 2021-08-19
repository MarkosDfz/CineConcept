
import 'package:cineapp/src/pages/reservar_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';

import 'package:cineapp/src/pages/detalle_page.dart';
import 'package:cineapp/src/pages/peliculas_page.dart';
import 'package:cineapp/src/services/pelicula_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider( create: (_) => new PeliculasService() )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'Home',
        onGenerateRoute: (RouteSettings routeSettings){
            return new PageRouteBuilder<dynamic>(
              settings: routeSettings,
              pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
                switch (routeSettings.name){
                  case 'Home':
                    return PeliculasPage();
                  case 'detalle':
                    return DetallePage();
                  case 'reservar':
                    return ReservarPage();
                  default:
                    return null;
                }
              },
              transitionDuration: const Duration(milliseconds: 500),
              transitionsBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation, Widget child) {
                  return effectMap[PageTransitionType.rippleMiddle](Curves.linear, animation, secondaryAnimation, child);
              }
            );
        }
      ),
    );

  }
  
}