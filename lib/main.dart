import 'package:flutter/material.dart';
import 'package:qr_scanner/screens/result_screen.dart';
import '/screens/scanner_screen.dart';

void main() {
  runApp(const QRScannerApp());
}

class QRScannerApp extends StatelessWidget {
  const QRScannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: ScannerScreen(),
    );
  }
}
