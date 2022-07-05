import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


class ContactService {
  static const String _url = 'https://jsonplaceholder.typicode.com/users';

  static Future<List<MessageModel>> browse() async{
    final http.Response _response = await http.get(Uri.parse(_url));

    final List<dynamic> _body = jsonDecode(_response.body);

    final List<MessageModel> _data = _body.map((e) => MessageModel.fromApp(e)).toList();

    return _data;
  }
}


class ContactManager {
  final StreamController <int> _contactCount = StreamController<int>();
  Stream<int> get contactCount => _contactCount.stream;

  Stream<List<MessageModel>> get contactListView async*{
    yield await ContactService.browse();
  }

  ContactManager() {
    contactListView.listen((event) => _contactCount.add(event.length));
  }
}


class MessageModel {
  final String name , email , phone;

  MessageModel({required this.name, required this.email , required this.phone});


  factory MessageModel.fromApp(Map<String,dynamic>map) {
    return MessageModel(
        name: map['name'] ,
        phone: map['phone'] ,
        email: map['email']
    );
  }


  Map<String,dynamic> toApp() => {
    "name" : name ,
  };
}