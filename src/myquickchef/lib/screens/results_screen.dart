// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:myquickchef/widgets/results_list.dart';

class ResultsScreen extends StatefulWidget {
  final XFile image;

  const ResultsScreen({
    super.key,
    required this.image,
  });

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const Border(
          bottom:
              BorderSide(color: Color.fromRGBO(244, 245, 247, 100), width: 6),
        ),
        surfaceTintColor: Colors.transparent,
        toolbarHeight: 90,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded),
            onPressed: () async {
              await Navigator.maybePop(context);
            },
          ),
        ), //icona back
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              icon: const Icon(
                Icons.refresh_rounded,
              ),
              iconSize: 30,
              onPressed: () {
                setState(() {});
              },
            ),
          )
        ],
        centerTitle: true,
        title: const Text(
          'Risultati',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ), //text risultati
      ),
      body: ResultsList(image: widget.image),
    );
  }
}
