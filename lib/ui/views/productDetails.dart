import 'package:flutter/material.dart';
import 'package:flutter_example/core/models/prescriptionModel.dart';
import 'package:flutter_example/core/viewmodels/CRUDModel.dart';
import 'package:flutter_example/ui/views/ModifyProduct.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';


class ProductDetails extends StatelessWidget {
  final Product product;

  ProductDetails({@required this.product });
  String img;
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<CRUDModel>(context);
    img = product.img;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        actions: <Widget>[

          IconButton(
            iconSize: 35,
            icon: Icon(Icons.delete_forever),
            onPressed: ()async {
              await productProvider.removeProduct(product.id);
              Navigator.pop(context) ;
            },
          ),
          IconButton(
            iconSize: 35,
            icon: Icon(Icons.edit),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=> ModifyProduct(product: product, )));
            },
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(bottom: 8.0,left: 12.0,right: 5.0),
        child:Wrap(
          direction: Axis.horizontal,
          alignment: WrapAlignment.center,
        children: <Widget>[
          Hero(
            tag: "133",
            child: new Image(image: new CachedNetworkImageProvider(
                product.img),
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          SizedBox(height: 10,width: 400,),
          Text(
            product.name,
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 22,
                fontStyle: FontStyle.italic),
          ),
          SizedBox(height: 10,width: 400,),
          Text(
            'Ингредиенты: ${product.ingredients} ',
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 18,
                fontStyle: FontStyle.italic,
                color: Colors.orangeAccent),
          ),
          SizedBox(height: 10,width: 400,),
          Text(
            'Способ приготовления: ${product.description} ',
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
