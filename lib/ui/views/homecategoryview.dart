import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/core/models/categoryModel.dart';
import 'package:flutter_example/core/viewmodels/CRUDModelCategory.dart';
import 'package:flutter_example/ui/widgets/categoryCard.dart';
import 'package:provider/provider.dart';

class HomeCategoryView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeCategoryView> {
  List<Categorys> categorys;

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CRUDModelCategory>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addProduct');
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Center(child: Text('111')),
      ),
      body: Container(
        child: StreamBuilder(
            stream: categoryProvider.fetchCategorysAsStream(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                categorys = snapshot.data.documents
                    .map((doc) => Categorys.fromMap(doc.data, doc.documentID))
                    .toList();
                return ListView.builder(
                  itemCount: categorys.length,
                  itemBuilder: (buildContext, index) =>
                      CategoryCard(categoryDetails: categorys[index]),
                );
              } else {
                return Text('fetching');
              }
            }),
      ),
    );
  }
}




