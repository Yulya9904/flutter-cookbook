import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_example/core/models/prescriptionModel.dart';
class SearchService {
  searchByName(String searchField) {
    return Firestore.instance
        .collection('products')
        .where('searchKey',
        isEqualTo: searchField.substring(0, 1).toUpperCase())
        .getDocuments();
  }
}

class Categorys {
  searchByName(String searchField) {
    return Firestore.instance
        .collection('products')
        .where('catid',
        isEqualTo: searchField)
        .getDocuments();
  }
}
