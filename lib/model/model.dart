import 'package:cepfinder/model/apiaddress/address.dart';


class Model {

  static Future<dynamic> retrieveDataApi(String searchtext) async => Address.retrieveDataApi(searchtext);

}