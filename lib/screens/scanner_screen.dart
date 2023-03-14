import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:http/http.dart' as http;

import '/screens/result_screen.dart';

class ScannerScreen extends StatefulWidget {
  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  String chekResult = "";
  bool isScanCompleted = false;
  bool isMatched = false;
  void closeScreen() {
    isScanCompleted = false;
    isMatched = false;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "QR Scanner",
          style: TextStyle(fontSize: 26, color: Colors.tealAccent),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        child: Column(
          children: [
            //Some guiding text
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Place the code in the area",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Scannig Will Start Automatically",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            //Implementing scanner
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: MobileScanner(onDetect: (capture) async {
                  if (!isScanCompleted) {
                    isScanCompleted = true;
                    final List<Barcode> barcodes = capture.barcodes;
                    for (final barcode in barcodes) {
                      debugPrint(
                          'Barcode found! ${barcode.rawValue.toString()}');
                      //TEST
                      var url = Uri.parse(
                          'https://qrscanner-67946-default-rtdb.firebaseio.com/.json');
                      final response = await http.get(url);
                      final extractedData = json.decode(response.body) as Map;
                      if (extractedData['codeId'].toString() ==
                          barcode.rawValue.toString()) {
                        isMatched = true;
                        setState(() {
                          chekResult = "User Found !";
                        });
                      } else {
                        setState(() {
                          chekResult = "No matching found!";
                        });
                      }
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ResultScreen(
                            closeScreen: closeScreen,
                            code: barcode.rawValue.toString(),
                            checkResult: chekResult,
                            isMatched: isMatched,
                          ),
                        ),
                      );
                    }
                  }
                }),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Developed by A.A",
                  style: TextStyle(color: Colors.tealAccent),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
