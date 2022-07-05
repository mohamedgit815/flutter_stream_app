import 'package:flutter/material.dart';
import 'package:flutter_streams_app/Api/contact_service.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({Key? key}) : super(key: key);

  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  @override
  Widget build(BuildContext context) {
    ContactManager manager = ContactManager();
    return Scaffold(
      body: StreamBuilder(
        stream: manager.contactListView,
          builder: (context,AsyncSnapshot<List<MessageModel>> snapshot) {
          List<MessageModel>? _contacts = snapshot.data;
            return ListView.builder(
            itemCount: _contacts?.length ?? 0,
            itemBuilder: (context,i)=>Column(
            children: const [

            ],
          ),
      );
          })
    );
  }
}
