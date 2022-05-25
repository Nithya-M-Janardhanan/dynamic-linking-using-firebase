import 'package:firebase_model/product_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'arguments_route.dart';
import 'homeScreen.dart';
import 'nav_const.dart';

class NavRouteGenerator {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initialRoute:
        return MaterialPageRoute(
          // settings: RouteSettings(name: initialRoute),
            builder: (_) => HomeScreen());
      case homeScreenRoute:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      // case loginScreenRoute:
      //   return MaterialPageRoute(builder: (_) => LoginScreen());
      // case sensorScreenRoute:
      //   return MaterialPageRoute(builder: (_) => Sensor());
      // case mainScreenRoute:
      //   return MaterialPageRoute(builder: (_) => MainScreen());
      // case accountScreenRoute:
      //   return MaterialPageRoute(builder: (_)=>AccountScreen());
      case productDetailScreenRoute:
        ArgumentsRoute route = settings.arguments as ArgumentsRoute;
        return MaterialPageRoute(builder: (_) => ProductDetail( value: route.products));
      // case notificationDataScreenRoute:
      //   ArgumentsRoute route = settings.arguments as ArgumentsRoute;
      //   return MaterialPageRoute(builder: (_) => NotificationData(data: route.id,));
      // case cartScreenRoute:
      //   return MaterialPageRoute(builder: (_)=>CartScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}
