import 'package:flutter/material.dart';
import 'package:flutter_example/core/models/prescriptionModel.dart';
import 'package:flutter_example/core/viewmodels/CRUDModel.dart';
import 'package:flutter_example/ui/views/ModifyProduct.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';


class ProductSearch extends StatelessWidget {
  final  data;
  ProductSearch({@required this.data });
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<CRUDModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(data['name']),
      ),
      body: Container(
        padding: const EdgeInsets.only(bottom: 8.0,left: 12.0,right: 5.0),
        child: Wrap(
          direction: Axis.horizontal,
          alignment: WrapAlignment.center,
          children: <Widget>[
            Hero(
              tag:'123',
              child: new Image(image: new CachedNetworkImageProvider(
                  data['img']),
                height: MediaQuery.of(context).size.height * 0.35,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            SizedBox(height: 10,width: 400,),
            Text(
              " ${data['name']}",
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 22,
                  fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 10,width: 400,),
            Text(
              'Ингредиенты: ${data['ingredients']}',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  color: Colors.orangeAccent),
            ),
            SizedBox(height: 10,width: 400,),
            Text(
              'Способ приготовления: ${data['description']}',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  color: Colors.black54),
            )
          ],
        ),
      ),);
  }
}
