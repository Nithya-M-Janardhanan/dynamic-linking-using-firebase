import 'package:flutter/material.dart';

class SliverAppbarSample extends StatefulWidget {
  const SliverAppbarSample({Key? key}) : super(key: key);

  @override
  State<SliverAppbarSample> createState() => _SliverAppbarSampleState();
}

class _SliverAppbarSampleState extends State<SliverAppbarSample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: const Icon(Icons.arrow_back_ios_sharp,color: Colors.white,),
            // shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15.0),bottomRight: Radius.circular(15.0))),
            actions: const [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(Icons.message,color: Colors.white,),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(Icons.account_circle_sharp,color: Colors.white,),
              )
            ],
            expandedHeight: 200,
            pinned: true,
            backgroundColor: Colors.green,
            foregroundColor: Colors.teal,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Animated Appbar'),
              background: Container(
                color: Colors.green,
              )
              // Image.network(
              //   'https://r-cf.bstatic.com/images/hotel/max1024x768/116/116281457.jpg',
              //   fit: BoxFit.fitWidth,
              // ),
            ),
          ),
          SliverList(delegate: SliverChildBuilderDelegate((context, index) {
            return const ListTile(
              title: Text('Name'),
              subtitle: Text('Address'),
              leading: Icon(Icons.person),
              trailing: Icon(Icons.cancel),
            );
          },
          childCount: 15
          ),
          )
          /*SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Text('Remaining Area'),
                  SizedBox(height: 10.0,),
                  Text('///////////')
                ],
              ),
            ),
          )*/
        ],
      ),
    );
  }
}
