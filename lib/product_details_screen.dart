import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_model/cart_provider.dart';
import 'package:firebase_model/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class ProductDetail extends StatefulWidget {
  final Value? value;
  const ProductDetail({Key? key, required this.value}) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  void initState() {
    super.initState();
    // FirebaseDynamicLinks.instance.onLink(onSuccess: (PendingDynamicLinkData? dynamicLink) async{
    //   final Uri? deepLink = dynamicLink?.link;
    //   Navigator.pushNamed(context, deepLink!.path);
    //   print(deepLink.path);
    // },
    //     onError: (OnLinkErrorException e)async
    //     {
    //       print(e.message);
    //     }
    // );
    // Future.microtask(() async{
    //   final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink();
    //   final Uri? deepLink = data?.link;
    //   if (deepLink != null) {
    //     print(deepLink.path);
    //      Navigator.pushNamed(context, deepLink.path);
    //   }
    // });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<CartProvider>(
        builder: (context, snapshot,child) {
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Image.network(widget.value?.image ?? '',height: 100,width: 100,),
                  Text(widget.value?.name ?? ''),
                  IconButton(onPressed: (){
                     shareProduct(context,widget.value?.name,widget.value?.image);
                  },
                      icon: Icon(Icons.share,size: 20,color: Colors.grey[400]))
                ],
              );
            },
            itemCount: 1,
          );
        }
      ),
    );
  }
  Future<String>createDynamicLink(BuildContext context,String? name,String? image)async{
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String packageName = packageInfo.packageName;
    final DynamicLinkParameters dynamicLinkParameters = DynamicLinkParameters(
        socialMetaTagParameters: SocialMetaTagParameters(
            description: 'Check this out $name on ekart',
          imageUrl: Uri.parse(image!)
        ),
        uriPrefix: "https://modelfirebaseapp.page.link",
        link: Uri.parse("https://www.google.com/?name=$name&image=$image"),
        androidParameters: AndroidParameters(packageName: 'com.example.firebase_model'));
    final link = await dynamicLinkParameters.buildUrl();
    print(link);
    final ShortDynamicLink shortenedLink =
    await DynamicLinkParameters.shortenUrl(
      Uri.parse(link.toString()),
      DynamicLinkParametersOptions(
          shortDynamicLinkPathLength: ShortDynamicLinkPathLength.unguessable),);
    return '${shortenedLink.shortUrl}';
  }
  Future<void> shareProduct(BuildContext context,String? name,String? image)async{
    try{
      String shareCode = await createDynamicLink(context,name,image);
      String text = 'Check this out $name \n$shareCode  on ekart';
      Share.share(text).whenComplete(() => Navigator.pop(context)).onError((error, stackTrace) => Navigator.pop(context));
    }catch(e){
      Navigator.pop(context);
    }
  }
}
