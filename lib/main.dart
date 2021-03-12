import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ui/router.dart';
import './locator.dart';
import 'core/viewmodels/CRUDModel.dart';
import 'core/viewmodels/CRUDModelCategory.dart';
void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => locator<CRUDModel>()),
        ChangeNotifierProvider(builder: (_) => locator<CRUDModelCategory>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false, //это скроет надпись “debug”.
        initialRoute: '/',
        title: 'Кулинарная книга',
        theme: ThemeData(),
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}

