import 'package:cepfinder/model/apiaddress/address.dart';


class Model {

  static Future<dynamic> retrieveDataWS(String searchtext) async => Address.retrieveDataWS(searchtext);

}