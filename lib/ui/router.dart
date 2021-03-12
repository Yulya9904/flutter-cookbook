import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'views/addProduct.dart';
import 'views/productDetails.dart';
import 'views/homeView.dart';
import 'views/Home.dart';
import 'views/search.dart';


class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/cat' :
        return  MaterialPageRoute(
          builder: (_)=> HomeView()
        );
      case '/add' :
        return  MaterialPageRoute(
            builder: (_)=> HomeView()
        );
      case '/search' :
        return  MaterialPageRoute(
            builder: (_)=> MyHomePage()
        );
      case '/' :
        return  MaterialPageRoute(
            builder: (_)=> HomeScreen()
        );
      case '/addProduct' :
        return MaterialPageRoute(
          builder: (_)=> AddProduct()
        ) ;

      case '/productDetails' :
        return MaterialPageRoute(
            builder: (_)=> ProductDetails()
        ) ;
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ));
    }
  }
}