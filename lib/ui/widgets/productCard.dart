import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_example/core/models/prescriptionModel.dart';
import 'package:flutter_example/ui/views/productDetails.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductCard extends StatelessWidget {
  final Product productDetails;
  final String catid;

  ProductCard({@required this.productDetails, this.catid});

  @override
  Widget build(BuildContext context) {
    if (catid == productDetails.catid) {

      return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (_) => ProductDetails(product: productDetails)));
        },
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Card(
            elevation: 5,
            child: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.45,
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.9,
              child: Column(
                children: <Widget>[

                  Hero(
                    tag: productDetails.id,
                    child: new Image(image: new CachedNetworkImageProvider(
                        productDetails.img),
                      height: MediaQuery
                          .of(context)
                          .size
                          .height *
                          0.35,
                    ),

                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '${productDetails.name} ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 22,
                              fontStyle: FontStyle.italic,
                              color: Colors.orangeAccent),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }
    else
      {
        return Text ('', style: TextStyle(fontSize: 0),);
      }
  }
}

