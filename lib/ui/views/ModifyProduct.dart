import 'package:flutter/material.dart';
import 'package:flutter_example/core/models/prescriptionModel.dart';
import 'package:flutter_example/core/viewmodels/CRUDModel.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:path/path.dart' as Path;
class ModifyProduct extends StatefulWidget {
  final Product product;


  ModifyProduct({@required this.product, });

  @override
  _ModifyProductState createState() => _ModifyProductState();
}

class _ModifyProductState extends State<ModifyProduct> {
  final _formKey = GlobalKey<FormState>();

  String title ;
  String _uploadedFileURL;
  String ingredients;
  String description;
  String price ;
  String searchKey ;
  File _image;
  String productType = "Первые блюда";
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<CRUDModel>(context);
    //String productType=widget.product.catid;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Изменить рецепт'),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.center,
            children: <Widget>[
              _image != null
                  ? Image.asset(
                _image.path,
                height: 120,
              )
                  : Container(),

              _image == null
              ? Image(image: new CachedNetworkImageProvider(
                  widget.product.img), height: 120,)
                  : Container(),
              SizedBox(height: 3,width: 400,),
              _image == null
                  ? Text('Выбранное изображение'):Container(),

              /*_image == null
                  ? RaisedButton(
                child: Text('Добавить изображение' , style: TextStyle(color: Colors.white)),
                onPressed: chooseFile,
                color: Colors.blue,
              )
                  : Container(),*/
              /*_image != null
                  ? RaisedButton(
                child: Text('Upload File'),
                onPressed: uploadFile,
                color: Colors.cyan,
              )
                  : Container(),*/
              SizedBox(height: 3,width: 400,),

              RaisedButton(
                child: Text('Выбрать другое', style: TextStyle(color: Colors.white)),
                onPressed: clearSelection,
                color: Colors.blue,
              ),

              TextFormField(
                  initialValue: widget.product.name,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: "Название",
                    hintText: 'Укажите название рецепта',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Укажите название рецепта';
                    }
                  },
                  onSaved: (value) => title = value
              ),
              SizedBox(height: 16,),
              SizedBox(
                width: 300.0,
                height:30,
                child:DropdownButton<String>(
                  value: productType,
                  icon: Icon(Icons.arrow_downward,),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(
                      color: Colors.blue
                  ),
                  underline: Container(
                    height: 2,
                    color: Colors.blue,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      productType = newValue;
                    });
                  },
                  items: <String>['Первые блюда','Вторые блюда','Салаты','Завтрак','Закуски','Напитки','Торты','Десерты']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                        value: value,
                        child:
                        new Text(value, style: TextStyle(fontSize: 14, ) ,textAlign: TextAlign.center,)
                    );
                  }).toList(),
                ),),

              TextFormField( maxLines: null,
                  initialValue: widget.product.ingredients,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Ингредиенты",
                    hintText: 'Укажите необходимые ингредиенты',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Вы не указали необходимые ингредиенты';
                    }
                  },
                  onSaved: (value) => ingredients = value
              ),
              SizedBox(height: 16,width: 400,),
              TextFormField( maxLines: null,
                  initialValue: widget.product.description,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Способ приготовления",
                    hintText: 'Опишите этапы приготовления блюда',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Пожалуйста, опишите способ приготовления';
                    }
                  },
                  onSaved: (value) => description = value
              ),

              RaisedButton(
                splashColor: Colors.red,
                onPressed: () =>[uploadFile()] ,
                child: Text('Добавить рецепт', style: TextStyle(color: Colors.white)),
                color: Colors.blue,
              ),


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
    if (_image==null) {
      _uploadedFileURL = widget.product.img;
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        var searchK=title;
        searchK=searchK.substring(0,1);
        await productProvider.updateProduct(Product(name: title,ingredients: ingredients,description: description,searchKey: searchK,catid:productType,img: _uploadedFileURL),widget.product.id);
        Navigator.pop(context) ;}

    } else {
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
          var searchK=title;
          searchK=searchK.substring(0,1);
          await productProvider.updateProduct(Product(name: title,ingredients: ingredients,description: description,searchKey: searchK,catid:productType,img: _uploadedFileURL),widget.product.id);
          Navigator.pop(context) ;
        }
      });
    });}


  }
  void clearSelection() async {
    setState(() {
      _image = null;
      _uploadedFileURL = null;
    });
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
      });
    });
  }
}
