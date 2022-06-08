import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class UISample extends StatefulWidget {
  const UISample({Key? key}) : super(key: key);

  @override
  State<UISample> createState() => _UISampleState();
}

class _UISampleState extends State<UISample> {
  List<String> images = [
    'https://media.istockphoto.com/photos/falling-antibiotics-healthcare-background-picture-id1300036753?k=20&m=1300036753&s=612x612&w=0&h=dlbqUqv7hXHw01H1CCycVV8ZhdsNpl_3iehkKasCi3E=',
    'https://images.mid-day.com/images/images/2022/apr/Pills-a_d.jpg',
    'https://www.medicaldevice-network.com/wp-content/uploads/sites/23/2021/02/shutterstock_544348294-1-1038x778.jpg',
    'https://media.istockphoto.com/photos/falling-antibiotics-healthcare-background-picture-id1300036753?k=20&m=1300036753&s=612x612&w=0&h=dlbqUqv7hXHw01H1CCycVV8ZhdsNpl_3iehkKasCi3E=',
    'https://images.mid-day.com/images/images/2022/apr/Pills-a_d.jpg',
    'https://www.medicaldevice-network.com/wp-content/uploads/sites/23/2021/02/shutterstock_544348294-1-1038x778.jpg',
    'https://images.mid-day.com/images/images/2022/apr/Pills-a_d.jpg',
  ];
  List<String> category = [
    'Pain & Fever',
    'Eye & Eye Care',
    'Cough Cold & Flu',
    'Digestive Support',
    'First Aid & Medical Supplies',
    'General Care',
    'Oral care'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Medical Essentials',style: TextStyle( color: Colors.black),),
      actions: [
        const Icon(Icons.search,color: Colors.black,),
        const SizedBox(width: 7.0,),
        const Icon(Icons.favorite_border,color: Colors.black),
        const SizedBox(width: 7.0,),
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Stack(
            children: [
              const Icon(Icons.shopping_cart,color: Colors.black),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Container(
                  height: 10,
                  width: 10,
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(width: 7.0,),
      ],
        leading: const Icon(Icons.arrow_back,color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: CustomScrollView(
        slivers: [
          SliverGrid(delegate: SliverChildBuilderDelegate((BuildContext context,int index){
            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(15)
                  ),
                  margin: const EdgeInsets.only(left: 20.0,right: 20.0,top: 10.0),
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                    // child: Image.asset('assets/images/med.jpg'),
                    child: Image.network(images[index]),
                  ),
                ),
                 Expanded(child: Text(category[index],style: const TextStyle(fontWeight: FontWeight.w500,),textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,maxLines: _maxLine(category[index])))
              ],
            );
          },childCount: images.length),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          ),
          SliverList(delegate: SliverChildBuilderDelegate((BuildContext context,int index){
            return Container(
              margin: const EdgeInsets.only(bottom: 7.0,left: 10.0,right: 10.0,top: 10.0),
              height: 150,
              decoration: BoxDecoration(
                  image: const DecorationImage(fit: BoxFit.fill, image: AssetImage('assets/images/medbanner.jpg')),
                  color: Colors.grey,
                borderRadius: BorderRadius.circular(15),
              ),
            );
          },
          childCount: 2
          ))
        ],
      )
      /*SingleChildScrollView(
        child: Column(
          children: [
            GridView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Container(color: Colors.green,margin: EdgeInsets.all(10.0),);
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemCount: 30,
            ),
            ListView.builder(itemBuilder: (context, index) {
              return Container(
                color: Colors.red,
                height: 200,
              );

            })
          ],
        ),
      ),*/
    );
  }
  int _maxLine(String title) {
    int val = 2;
    if (!title.trim().contains(' ')) {
      val = 1;
    }
    return val;
  }
}
