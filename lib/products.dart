import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_model/arguments_route.dart';
import 'package:firebase_model/nav_const.dart';
import 'package:firebase_model/product_details_screen.dart';
import 'package:firebase_model/product_model.dart';
import 'package:firebase_model/product_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'cart_provider.dart';
import 'const.dart';
import 'custom_widget.dart';
import 'fav_provider.dart';
import 'hexcolor.dart';


class ProductsWidget extends StatelessWidget {
  ValueNotifier<bool> isfav = ValueNotifier<bool>(false);
  var item;
  @override
  Widget build(BuildContext context) {
    return Consumer3<HomeProvider,CartProvider,FavouritesProvider>(
        builder: (context, snapshot,model,fav,child) {
          final productItem = snapshot.homeModel?.homeData?.firstWhere(
            ((element) {
              if (element.type != null) {
                return element.type == "products";
              } else {
                return false;
              }
            }),
            orElse: () => HomeDatum(),
          );
          // if(productItem == null || productItem.type ==null){
          //   return const SizedBox();
          // }
          return
            Container(
              height: 280,
              width: double.maxFinite,
              child: ListView.builder(
                itemCount: productItem?.values?.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index){
                  item = productItem?.values?.elementAt(index);
                  final check = model.cartModel?.firstWhere((element) => element.value?.id == productItem?.values?[index].id,orElse: ()=>CartModel());
                  final favCheck = fav.favList?.firstWhere((element) => element.favourites?.id == productItem?.values?[index].id,orElse: ()=>FavouritesModel());
                  return
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetail(value: productItem?.values?[index])));
                      },
                      child: Container(
                          width: 170.0,
                          margin: const EdgeInsets.only(left: 10),
                          child:
                          Container(
                            margin: const EdgeInsets.only(right: 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                                border: Border.all(color: HexColor("#FFEAEAEA"))),
                            child: productItem == null || productItem.type ==null ? const CustomWidget.rectangular(height: 10,) :
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(right: 10.0),
                                  child:
                                  Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    child:
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        productItem.values?[index].offer == 0 ? SizedBox() :
                                        Stack(children: [
                                          // Image.asset(Const.redTag),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 3.0,),
                                                child: Text('${productItem.values?[index].offer}',style: const TextStyle(color: Colors.white,fontSize: 10),),
                                              ),
                                              const Icon(Icons.percent,color: Colors.white,size: 10,),
                                              Text('OFF',style: TextStyle(color: Colors.white,fontSize: 10))
                                            ],
                                          )
                                        ],),
                                        Column(
                                          children: [
                                            GestureDetector(
                                              onTap: (){
                                                final check = fav.favList?.firstWhere((element) => element.favourites?.id == productItem.values?[index].id,orElse: ()=>FavouritesModel());
                                                if(check?.favourites == null){
                                                  context.read<FavouritesProvider>().insertFavItems(productItem.values![index]);
                                                }else{
                                                  context.read<FavouritesProvider>().deleteFavouritesItem(check?.id);
                                                }
                                              },
                                              child:
                                              favCheck?.favourites != null ? Icon(Icons.favorite,color: Colors.red,) :
                                              IconButton(onPressed: ()async{

                                              },
                                                  icon: Icon(Icons.favorite,size: 20,color: Colors.grey[400],))
                                            ),
                                            // IconButton(onPressed: ()async{
                                            //   shareProduct(context,productItem.values?[index].name);
                                            // },
                                            //     icon: Icon(Icons.share,size: 20,color: Colors.grey[400],))
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                        alignment: Alignment.center,
                                        child:
                                        // FadeInImage.assetNetwork(placeholder: 'https://media.istockphoto.com/vectors/thumbnail-image-vector-graphic-vector-id1147544807?k=20&m=1147544807&s=612x612&w=0&h=pBhz1dkwsCMq37Udtp9sfxbjaMl27JUapoyYpQm0anc=', image: productItem.values?[index].image ??'',height: 90,width: 90,)
                                          Image.network(productItem.values?[index].image ??'',height: 90,width: 90)
                                    )),
                                Container(
                                    margin: const EdgeInsets.only( left: 11.0),
                                    child: productItem.values![index].isExpress! ?
                                    Icon(Icons.train) :  Container(height: 14,width: 22,)
                                ),
                                Container(
                                    margin: const EdgeInsets.only( left: 11.0),
                                    child:productItem.values?[index].actualPrice! == productItem.values?[index].offerPrice! ? SizedBox() :
                                    Text(productItem.values?[index].actualPrice??'',style: TextStyle(decoration: TextDecoration.lineThrough,color: HexColor('#727272'),fontSize: 12),)
                                ),
                                Container(
                                    margin: const EdgeInsets.only( left: 11.0),
                                    child: Text(productItem.values?[index].offerPrice ?? '',style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)
                                ),
                                Container(
                                  margin: const EdgeInsets.only( left: 11.0,),
                                  child: Text((productItem.values?[index].name ?? '')+'\n',style:  TextStyle(fontSize: 14.0,),maxLines: 2,),
                                ),

                                Container(
                                    alignment: Alignment.center,
                                    child:Column(children: [
                                      check?.count != null ?
                                      Padding(
                                        padding: const EdgeInsets.only(left: 15.0),
                                        child: Row(
                                          children: [
                                            IconButton(onPressed: (){
                                              final check = model.cartModel?.firstWhere((element) => element.value?.id == productItem.values?[index].id,orElse: ()=>CartModel());
                                              int countMinus = check?.count ?? 0;
                                              countMinus = countMinus - 1;
                                              if(countMinus <= 0){
                                                context.read<CartProvider>().deleteData(check?.id);
                                              }else{
                                                context.read<CartProvider>().updateCountfn(check?.id, countMinus);
                                              }
                                            }, icon: Container(decoration:  BoxDecoration(shape: BoxShape.circle,color: Colors.grey[300]),child: Icon(Icons.remove,color: HexColor('#199B3B'),))),
                                            // count(model.cartModel),
                                            check?.count == null ? Text('0') : Text('${check?.count}'),
                                            IconButton(onPressed: ()async{
                                              final check = model.cartModel?.firstWhere((element) => element.value?.id == productItem.values?[index].id,orElse: ()=>CartModel());
                                              if(check?.value != null){
                                                if(check?.count != null){
                                                  int? count = check?.count ?? 0;
                                                  count = count + 1;
                                                  context.read<CartProvider>().updateCountfn(check?.id, count);
                                                }
                                              }else{
                                                context.read<CartProvider>().insertProducts(productItem.values![index]);
                                              }
                                            }, icon: Container(decoration:  BoxDecoration(shape: BoxShape.circle,color: Colors.grey[300]),child: Icon(Icons.add,color: HexColor('#199B3B'),))),
                                          ],
                                        ),
                                      ) :
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(primary: HexColor('#199B3B'),minimumSize: Size(110, 30)),
                                        onPressed: (){
                                          context.read<CartProvider>().insertProducts(productItem.values![index]);
                                          // context.read<ContactsProvider>().loadProducts();
                                        },
                                        child: Text('ADD'),
                                      ),
                                    ],)
                                )
                              ],
                            ),
                          )
                      ),
                    );
                },


              ),
            );
        }
    );
  }

  // Future<String>createDynamicLink(BuildContext context,String? name)async{
  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //   String packageName = packageInfo.packageName;
  //   final DynamicLinkParameters dynamicLinkParameters = DynamicLinkParameters(
  //       socialMetaTagParameters: SocialMetaTagParameters(
  //           description: 'Check this out $name on ekart'
  //       ),
  //       uriPrefix: "https://modelfirebaseapp.page.link",
  //       link: Uri.parse("https://www.google.com/?name=$name"),
  //       androidParameters: AndroidParameters(packageName: 'com.example.firebase_model'));
  //   final link = await dynamicLinkParameters.buildUrl();
  //   print(link);
  //   final ShortDynamicLink shortenedLink =
  //   await DynamicLinkParameters.shortenUrl(
  //     Uri.parse(link.toString()),
  //     DynamicLinkParametersOptions(
  //         shortDynamicLinkPathLength: ShortDynamicLinkPathLength.unguessable),);
  //   return '${shortenedLink.shortUrl}';
  // }
  // Future<void> shareProduct(BuildContext context,String? name)async{
  //   try{
  //     String shareCode = await createDynamicLink(context,name);
  //     String text = 'Check this out \n$shareCode  on ekart';
  //     Share.share(text).whenComplete(() => Navigator.pop(context)).onError((error, stackTrace) => Navigator.pop(context));
  //   }catch(e){
  //     Navigator.pop(context);
  //   }
  // }
}
