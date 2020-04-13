import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:cepfinder/model/model.dart';

class Controller extends ControllerMVC {

  static Future<dynamic> retrieveDataWS(String searchtext) => Model.retrieveDataWS(searchtext);
  
}