import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_streams_app/data_model.dart';

class Home1Page extends ConsumerStatefulWidget {
  const Home1Page({Key? key}) : super(key: key);

  @override
  _Home1PageState createState() => _Home1PageState();
}

class _Home1PageState extends ConsumerState<Home1Page> {

  final StreamController<DataModel> _streamController = StreamController<
      DataModel>();
  late StreamProvider<DataModel> _dataStream;

  @override
  void initState() {
    super.initState();
    _dataStream = StreamProvider<DataModel>((ref) => _streamController.stream);

    Timer.periodic(const Duration(seconds: 3), (timer) {
      print("Google");
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
    print("Bing");

    return Scaffold(
      appBar: AppBar(title: const Text('RiverPod'),centerTitle: true,),
        body: Consumer(
            builder: (context, prov, _) => prov.watch(_dataStream).when(
                error: (err,stack)=>Text(err.toString()),
                loading: ()=>const Center(child: CircularProgressIndicator.adaptive()) ,
                data: (data)=>Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: Text(data.name.toString())),

                    Center(child: Text(data.price.toString()))

                  ],
                )
            )
        )
    );
  }
}
