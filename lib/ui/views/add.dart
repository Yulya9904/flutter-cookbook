import 'package:flutter/material.dart';
import 'package:flutter_example/core/models/prescriptionModel.dart';
import 'package:provider/provider.dart';
import '../../core/viewmodels/CRUDModel.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:auto_size_text/auto_size_text.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  String title ;
  String price ;
  String ingredients ;
  String description ;
  String searchKey ;
  File _image;
  String _uploadedFileURL;
  String productType = 'Первое блюдо';


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:  Text('Добавить рецепт'),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[

              _image != null
                  ? Image.asset(
                _image.path,
                height: 150,
              )
                  : Container(),
              _image == null
                  ? RaisedButton(
                child: Text('Выберите изображение'),
                onPressed: chooseFile,
                color: Colors.cyan,
              )
                  : Container(),
              _image != null
                  ? RaisedButton(
                child: Text('Upload File'),
                onPressed: uploadFile,
                color: Colors.cyan,
              )
                  : Container(),
              _image != null
                  ? RaisedButton(
                child: Text('Clear Selection'),
                onPressed: clearSelection,
              )
                  : Container(),
              Text('Uploaded Image'),
              _uploadedFileURL != null
                  ? Image.network(
                _uploadedFileURL,
                height: 150,
              )
                  : Container(),
              TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Наименование рецепта',
                    fillColor: Colors.grey[300],
                    filled: true,
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Напишите название рецепта';
                    }
                  },
                  onSaved: (value) => title = value
              ),
              SizedBox(height: 16,),
              DropdownButton<String>(
                value: productType,
                onChanged: (String newValue) {
                  setState(() {
                    productType = newValue;
                  });
                },
                items: <String>['Первое блюдо', 'Вторые блюда', 'Салаты', 'Завтрак','Закуски']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Text',
                    fillColor: Colors.grey[300],
                    filled: true,
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter The price';
                    }
                  },
                  onSaved: (value) => ingredients = value
              ),
              AutoSizeText(
                'A really long String',
                style: TextStyle(fontSize: 30),
                minFontSize: 18,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,

              ),
              RaisedButton(
                splashColor: Colors.red,
                onPressed: () =>[uploadFile()] ,
                child: Text('Добавить рецепт', style: TextStyle(color: Colors.white)),
                color: Colors.blue,
              )

            ],
          ),
        ),
      ),
    );
  }
  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
      });
    });
  }

  Future uploadFile() async {
    var productProvider = Provider.of<CRUDModel>(context) ;
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('categorys/${Path.basename(_image.path)}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() async {
        _uploadedFileURL = fileURL;
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          await productProvider.addProduct(Product(name: title,ingredients: ingredients,description: description,searchKey: "q",catid:productType.toLowerCase(),img: _uploadedFileURL));
          Navigator.pop(context) ;}
      });
    });


  }

  void clearSelection() {
    setState(() {
      _image = null;
      _uploadedFileURL = null;
    });
  }
// ignore: non_constant_identifier_names

}
