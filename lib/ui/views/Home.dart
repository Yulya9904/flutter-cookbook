import 'package:flutter_example/core/models/prescriptionModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_sidebar/mobile_sidebar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'homeView.dart';
import 'dart:async';
import 'package:flutter_example/core/services/searchservice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_example/core/viewmodels/CRUDModel.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var Cat = [
    'Первые блюда',
    'Вторые блюда',
    'Салаты',
    'Завтрак',
    'Закуски',
    'Напитки',
    'Торты',
    'Десерты'
  ];

  bool _showList = false;
  final _breakpoint = 700.0;
  var numb = [0, 0, 0, 0, 0, 0, 0, 0];
  @override

  Future _reDrawWidget() async {
    for (int i = 0; i < Cat.length; ++i) {
      await Categorys().searchByName(Cat[i]).then((QuerySnapshot docs) {
        numb[i] = docs.documents.length;
        print(Cat[i]); //print(i);print(numb[i]);
        print(docs.documents.length); //(numb[i]);
      });
    }
    setState(() {print('reDrawWidget()');});
  }
  void initState() {
    // TODO: implement initState
    super.initState();

    _reDrawWidget();
  }



  @override
  Widget build(BuildContext context) {
    //_reDrawWidget();
    return Scaffold(
      appBar: AppBar(
        title: Text('Категории блюд'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
          ),
          if (MediaQuery.of(context).size.width < _breakpoint) ...[
            IconButton(
              icon: Icon(_showList ? Icons.grid_on : Icons.grid_off),
              onPressed: () {
                if (mounted)
                  setState(() {
                    _showList = !_showList;
                  });
              },
            )
          ]
        ],
      ),
      body: Center(
        child: MobileSidebar(
          items: <MenuItem>[
            MenuItem(
                icon: MdiIcons.bowl,
                color: Colors.redAccent,
                title: Cat[0],
                subtitle: 'Всего рецептов: ${numb[0]}',
                child: HomeView(
                  catid: Cat[0],
                )),
            MenuItem(
                icon: MdiIcons.pasta,
                color: Colors.lightBlueAccent,
                title: Cat[1],
                subtitle: 'Всего рецептов: ${numb[1]}',
                child: HomeView(catid: Cat[1])
                /*RaisedButton(onPressed:(){Navigator.push(context, MaterialPageRoute(
                builder: (_)=> HomeView()
            ),);} , child: Text('123'),)*/
                ),
            MenuItem(
                icon: MdiIcons.silverware,
                color: Colors.indigoAccent,
                title: Cat[2],
                subtitle: 'Всего рецептов: ${numb[2]}',
                child: HomeView(catid: Cat[2])),
            MenuItem(
              color: Colors.amber,
              icon: MdiIcons.foodVariant,
              title: Cat[3],
              subtitle: 'Всего рецептов: ${numb[3]}',
              child: HomeView(catid: Cat[3]),
            ),
            MenuItem(
              icon: FontAwesomeIcons.utensils,
              color: Colors.green,
              title: Cat[4],
              subtitle: 'Всего рецептов: ${numb[4]}',
              child: HomeView(catid: Cat[4]),
            ),
            MenuItem(
              icon: MdiIcons.cupWater,
              color: Colors.deepOrangeAccent,
              title: Cat[5],
              subtitle: 'Всего рецептов: ${numb[5]}',
              child: HomeView(catid: Cat[5]),
            ),
            MenuItem(
                icon: Icons.cake,
                color: Colors.greenAccent,
                title: Cat[6],
                subtitle: 'Всего рецептов: ${numb[6]}',
                child: HomeView(catid: Cat[6])),
            MenuItem(
                color: Colors.pinkAccent,
                icon: MdiIcons.foodCroissant,
                title: Cat[7],
                subtitle: 'Всего рецептов: ${numb[7]}',
                child: HomeView(catid: Cat[7])),
          ],
          showList: _showList,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Colors.redAccent,
            heroTag: 'create-contact',
            label: Text('Добавить рецепт'),
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/addProduct');
            },
          ),
        ),
      ),
    );
  }
}
