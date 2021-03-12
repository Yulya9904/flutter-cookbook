import 'dart:async';
import 'package:flutter/material.dart';
import '../../locator.dart';
import '../services/api.dart';
import '../models/categoryModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CRUDModelCategory extends ChangeNotifier {
  Api _api = locator<Api>();

  List<Categorys> categorys;


  Future<List<Categorys>> fetchCategorys() async {
    var result = await _api.getDataCollection();
    categorys = result.documents
        .map((doc) => Categorys.fromMap(doc.data, doc.documentID))
        .toList();
    return categorys;
  }

  Stream<QuerySnapshot> fetchCategorysAsStream() {
    return _api.streamDataCollection();
  }

  Future<Categorys> getCategorysById(String id) async {
    var doc = await _api.getDocumentById(id);
    return  Categorys.fromMap(doc.data, doc.documentID) ;
  }


  Future removeCategorys(String id) async{
    await _api.removeDocument(id) ;
    return ;
  }
  Future updateCategorys(Categorys data,String id) async{
    await _api.updateDocument(data.toJson(), id) ;
    return ;
  }

  Future addCategorys(Categorys data) async{
    var result  = await _api.addDocument(data.toJson()) ;

    return ;

  }


}
