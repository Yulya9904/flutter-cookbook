
import 'package:get_it/get_it.dart';
import 'core/services/api.dart';
import 'core/viewmodels/CRUDModel.dart';
import 'core/viewmodels/CRUDModelCategory.dart';
GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(() => Api('products'));
  //locator.registerLazySingleton(() => Api('categorys'));
  locator.registerLazySingleton(() => CRUDModel()) ;
  locator.registerLazySingleton(() => CRUDModelCategory()) ;
}