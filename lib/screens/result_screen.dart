import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ResultScreen extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              closeScreen();
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
              data: code,
              size: 150,
              version: QrVersions.auto,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Qr RESULT : $code",
              style: TextStyle(color: Colors.amber, fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            isMatched
                ? Text(
                    "Check result : $checkResult",
                    style: const TextStyle(
                        color: Colors.green,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  )
                : Text(
                    "Check result : $checkResult",
                    style: const TextStyle(
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
