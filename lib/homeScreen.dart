import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_model/product_details_screen.dart';
import 'package:firebase_model/product_model.dart';
import 'package:firebase_model/product_provider.dart';
import 'package:firebase_model/products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'banner.dart';
import 'categories.dart';
import 'fav_provider.dart';
import 'helpers.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink(onSuccess:
         (PendingDynamicLinkData? dynamicLink) async {
          final Uri? deepLink = dynamicLink?.link;

          if (deepLink != null) {
            // Navigator.pushNamed(context, deepLink.path);
            getProductFromLink(deepLink.queryParameters);
          }
        },
        onError: (OnLinkErrorException e)async{
           print(e.message);
        },

    );

    final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;

    if (deepLink != null) {
      getProductFromLink(deepLink.queryParameters);
    }
  }


  void getProductFromLink(Map<String, dynamic> deepLinkParams) {
    if (deepLinkParams.containsKey('name')) {
      print('=========${deepLinkParams['name']}');
      Value value =Value(name: deepLinkParams['name'],image: deepLinkParams['image']);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetail(value: value)));
    } else {
      print('cannot navigate');
    }
  }
  @override
  void initState() {
    initDynamicLinks();
    Future.microtask(() =>context.read<HomeProvider>().getData() );
    Future.microtask(() => context.read<FavouritesProvider>().loadFavList());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // final translated = S.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer<HomeProvider>(builder: (context, snapshot, child) {
          // if (snapshot.homeModel?.homeData == null) {
          //   return const Center(
          //     child: CircularProgressIndicator(),
          //   );
          // }
          return Container(
            width: double.maxFinite,
            height: double.maxFinite,
            child: Column(
              children: [
                // SearchWidget(),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CategoriesWidget(),
                        HomeBanner(),
                        ProductsWidget()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
