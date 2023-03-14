import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_scanner/screens/scanner_screen.dart';
import 'package:http/http.dart' as http;

class ResultScreen extends StatefulWidget {
  @override
  State<ResultScreen> createState() => _ResultScreenState();
  String code;
  final Function() closeScreen;
  String checkResult;
  bool isMatched;

  ResultScreen({
    required this.closeScreen,
    required this.code,
    required this.checkResult,
    required this.isMatched,
  });
}

class _ResultScreenState extends State<ResultScreen> {
  String codeId = "No matching found !";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              widget.closeScreen();
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.teal,
            )),
        centerTitle: true,
        title: const Text(
          "Scannig Result",
          style: TextStyle(color: Colors.tealAccent),
        ),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImage(
              data: widget.code,
              size: 150,
              version: QrVersions.auto,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Qr RESULT : ${widget.code}",
              style: TextStyle(color: Colors.amber, fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            widget.isMatched
                ? Text(
                    "Check result : ${widget.checkResult}",
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  )
                : Text(
                    "Check result : ${widget.checkResult}",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
          ],
        ),
      ),
    );
  }
}
