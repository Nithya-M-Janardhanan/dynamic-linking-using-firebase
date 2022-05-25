import 'package:firebase_model/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart'as http;

import 'api_services.dart';

class HomeProvider extends ChangeNotifier{
  HomeModel? homeModel;

  Future<void> getData() async{
    Future.delayed(Duration(seconds: 1),()async{
      homeModel = await ApiServices().getData();
      notifyListeners();
    });


  }

}
