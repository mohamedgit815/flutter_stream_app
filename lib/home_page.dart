import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_streams_app/data_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final StreamController<DataModel> _streamController = StreamController<DataModel>();

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 3), (timer) {
      DataModel.getCryptoPrice(_streamController);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Normal'),centerTitle: true),
      body: StreamBuilder(
        stream: _streamController.stream,
        builder: (context,AsyncSnapshot<DataModel> snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator.adaptive());
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center ,
              children: [
                Center(child: Text(snapshot.data!.name.toString())) ,

                Text(snapshot.data!.price.toString())

              ],
            );
          }
        },
      ),
    );
  }
}
