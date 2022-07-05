import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


class DataModel {
  final String name , price;

  DataModel({required this.name, required this.price});

  factory DataModel.fromApp(Map<String,dynamic>map) {
    return DataModel(
        name: map['name'] ,
        price: map['price']
    );
  }

  Map<String,dynamic> toApp() => {
    "name" : name ,
    "price" : price
  };


  static Future<void> getCryptoPrice(StreamController streamController) async {
    final http.Response _response = await http.get(Uri.parse('https://api.nomics.com/v1/currencies/ticker?key=0ec15727bece63da35ead7eaf7a41ead5621d1d5&ids=BTC'));
    final _data = await jsonDecode(_response.body)[0];

    final DataModel _model = DataModel.fromApp(_data);
    return streamController.sink.add(_model);
  }
}