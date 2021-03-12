import 'package:flutter/material.dart';
import 'package:flutter_example/core/models/categoryModel.dart';
import 'package:flutter_example/core/viewmodels/CRUDModelCategory.dart';
import 'package:flutter_example/ui/views/ModifyProduct.dart';
import 'package:provider/provider.dart';

class CategoryDetails extends StatelessWidget {
  final Categorys categorys;

  CategoryDetails({@required this.categorys});
  String img;
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<CRUDModelCategory>(context);
    img = categorys.img;
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
        actions: <Widget>[

          IconButton(
            iconSize: 35,
            icon: Icon(Icons.delete_forever),
            onPressed: ()async {
              await productProvider.removeCategorys(categorys.id);
              Navigator.pop(context) ;
            },
          ),
          IconButton(
            iconSize: 35,
            icon: Icon(Icons.edit),
            onPressed: (){
              //Navigator.push(context, MaterialPageRoute(builder: (_)=> ModifyProduct(product: product,)));
            },
          )
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Hero(
            tag: categorys.id,
            child: Image.network(
              img,
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            categorys.name,
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 22,
                fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}
