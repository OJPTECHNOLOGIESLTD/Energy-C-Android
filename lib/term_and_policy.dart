import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'dart:io';
import 'package:flutter/services.dart'; // For rootBundle
import 'package:path_provider/path_provider.dart';

class TermsAndPolicy extends StatefulWidget {
  const TermsAndPolicy({super.key});

  @override
  State<TermsAndPolicy> createState() => _TermsAndPolicyState();
}

class _TermsAndPolicyState extends State<TermsAndPolicy> {
  late PdfControllerPinch _pdfController;
  String? localPath;

  @override
  void initState() {
    super.initState();
    _loadPDF();
  }

  Future<void> _loadPDF() async {
    final ByteData data = await rootBundle.load("assets/ENERGYCHLEEN-TermsOfServiceAgencyAgreementandPrivacyPolicy.pdf");
    final Directory tempDir = await getTemporaryDirectory();
    final File tempFile = File("${tempDir.path}/ENERGYCHLEEN-TermsOfServiceAgencyAgreementandPrivacyPolicy.pdf");
    await tempFile.writeAsBytes(data.buffer.asUint8List(), flush: true);

    setState(() {
      localPath = tempFile.path;
      _pdfController = PdfControllerPinch(document: PdfDocument.openFile(localPath!));
    });
  }

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Terms and Policy")),
      body: localPath == null
          ? Center(child: CircularProgressIndicator())
          : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: PdfViewPinch(
                  padding: 10,
                  
                  scrollDirection: Axis.vertical,
                  controller: _pdfController),
              ),
            ],
          ),
    );
  }
}