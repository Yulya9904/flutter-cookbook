import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/core/models/prescriptionModel.dart';
import 'package:flutter_example/core/viewmodels/CRUDModel.dart';
import 'package:flutter_example/ui/widgets/productCard.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class HomeView extends StatefulWidget {
  final String todos;
  final String catid;

  HomeView({Key key, @required this.todos, this.catid}) : super(key: key);
  @override
  _HomeViewState createState() => _HomeViewState(catid: catid);
}

class _HomeViewState extends State<HomeView> {
  final String catid;

  _HomeViewState({Key key, this.catid});

  List<Product> products;
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<CRUDModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(catid,),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Increase volume by 10',
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            tooltip: 'Increase volume by 10',
            onPressed: () {
              Navigator.pushNamed(context, '/addProduct');
            },
          ),
        ],),
      body: Container(
        child: StreamBuilder(
            stream: productProvider.fetchProductsAsStream(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                products = snapshot.data.documents
                    .map((doc) => Product.fromMap(doc.data, doc.documentID))
                    .toList();
                return ListView.builder(

                  itemCount: products.length,
                  itemBuilder: (buildContext, index) =>
                      ProductCard(productDetails: products[index],catid: catid,),
                );
              } else {
                return SpinKitFadingCircle(
                  itemBuilder: (BuildContext context, int index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        color: index.isEven ? Colors.yellow : Colors.blue,
                      ),
                    );
                  },
                );
              }
            }),
      ),
    );
    ;
  }
}
