import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/core/services/searchservice.dart';
import 'package:flutter_example/core/models/prescriptionModel.dart';
import 'package:flutter_example/ui/views/productDetails.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_example/ui/views/se.dart';
import 'package:flutter_example/core/viewmodels/CRUDModel.dart';
import 'package:flutter_example/ui/widgets/productCard.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var queryResultSet = [];
  var tempSearchStore = [];
  String idDOc;

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }

    var capitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);

    if (queryResultSet.length == 0 && value.length==1) {
      SearchService().searchByName(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.documents.length; ++i) {
         // idDOc='id: '+docs.documents[i].documentID;
          queryResultSet.add(docs.documents[i].data);
          tempSearchStore = [];
          print(queryResultSet);
          queryResultSet.forEach((element) {
            if (element['name'].startsWith(capitalizedValue)) {
              setState(() {
                tempSearchStore.add(element);
                print(tempSearchStore);
              });
            }
          });
        }
      });
    } else {
      tempSearchStore = [];
      print(queryResultSet);
      queryResultSet.forEach((element) {
        if (element['name'].startsWith(capitalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
            print(tempSearchStore);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<CRUDModel>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Поиск'),
        ),
        body: ListView(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: (val) {
                initiateSearch(val);
              },
              decoration: InputDecoration(
                  prefixIcon: IconButton(
                    icon: Icon(Icons.search),
                    iconSize: 20.0,
                    onPressed: () {

                    },
                  ),
                  hintText: 'Введите название',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25))),
            ),
          ),
          SizedBox(height: 10.0),
          GridView.count(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              crossAxisCount: 2,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
              primary: false,
              shrinkWrap: true,
              children: tempSearchStore.map((element) {
                return buildResultCard(element);
              }).toList())
        ]));
  }


  Widget buildResultCard(data) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (_)=> ProductSearch(data: data)));
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 2.0,
        child: Container(
          child: Column(
            children: <Widget>[
              Hero(
                tag:123,
                child: new Image(image: new CachedNetworkImageProvider(
                  data['img']),height: 150 ,
                  width: 150,
                ),
              ),
              Text(
                data['name'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,),
              ),
            ],
          ),

        ),
      ),);
  }
}