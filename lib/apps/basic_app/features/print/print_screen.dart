import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PrintScreen extends StatefulWidget {
  const PrintScreen({super.key});

  @override
  State<PrintScreen> createState() => _PrintScreenState();
}

class _PrintScreenState extends State<PrintScreen> {
  Future<void> printDoc() async {
    print("INSIDE FUNCTION");
    final doc = pw.Document();
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text('Hello World'),
          );
        },
      ),
    );
    //await Printing.layoutPdf(
    //    onLayout: (PdfPageFormat format) async => doc.save());

    //프린터 들을 찾고
    List<Printer> printers = await Printing.listPrinters();
    print('printers:$printers');
    //원하는 프린터를 선택하고
    Printer? printer = const Printer(url: 'HP419A54 (HP OfficeJet Pro 8710)');
    print('printer:$printer');
    //다이렉트로 출력
    await Printing.directPrintPdf(
        onLayout: (PdfPageFormat format) async => doc.save(), printer: printer);

    print("DONE");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Print'),
      ),
      body: ElevatedButton(
        onPressed: () {
          printDoc();
        },
        child: const Text('print'),
      ),
    );
  }
}
