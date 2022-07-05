import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_streams_app/Api/contact_service.dart';
import 'package:flutter_streams_app/home_page.dart';


void main() async {
  final List<MessageModel> _test = await  ContactService.browse();
  print(_test.elementAt(1).name);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo' ,
      //home:  Home1Page()
     home:  HomePage()
    );
  }
}