// import 'package:flutter/material.dart';
// import 'package:mmg/app/bookings/model%20view/booking_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// /// Represents Homepage for Navigation
// class PdfViewer extends StatefulWidget {
//   const PdfViewer({super.key});

//   @override
//   _PdfViewer createState() => _PdfViewer();
// }

// class _PdfViewer extends State<PdfViewer> {
//   final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<BookingProvider>(builder: (context, obj, _) {
//       return Scaffold(
//         body: obj.bytes == null
//             ? Container()
//             : SfPdfViewer.memory(
//                 obj.bytes!,
//                 key: _pdfViewerKey,
//               ),
//       );
//     });
//   }
// }

import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:mmg/app/utils/apppref.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class PdfViewer extends StatefulWidget {
  const PdfViewer({super.key});

  @override
  _PdfViewerState createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  String _pdfPath = '';
  Uint8List? _pdfdata;
  Future<void> _fetchPdfData() async {
    log("PDF VIEWER message");
    final response = await http.get(
        Uri.parse(
            'http://103.160.153.57:8087/mmg/api/v2/downloadInvoice/booking/711950406874'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppPref.userToken}',
          'x-api-key': 'MMGATPL'
        });

    log("PDF VIEWER ${response.bodyBytes}");
    _pdfdata = response.bodyBytes;
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/invoice.pdf");
    await file.writeAsBytes(response.bodyBytes);
    setState(() {
      _pdfPath = file.path;
    });
    await OpenFile.open(_pdfPath);

    log("PDF VIEWER $_pdfPath");
  }

  @override
  void initState() {
    super.initState();
    _fetchPdfData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer'),
      ),
      body: _pdfPath.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : PDFView(
              pdfData: _pdfdata,
              filePath: _pdfPath,
              enableSwipe: true,
              swipeHorizontal: false,
              autoSpacing: false,
              pageSnap: false,
              defaultPage: 0,
              fitPolicy: FitPolicy.BOTH,
              preventLinkNavigation: false,
              onRender: (pages) {
                log("PDF VIEWER pages $pages");
                setState(() {});
              },
              onError: (error) {
                log("PDF VIEWER error1 $error");
              },
              onPageError: (page, error) {
                log('PDF VIEWER error2 $page: ${error.toString()}');
              },
              onViewCreated: (PDFViewController pdfViewController) {
                log("PDF VIEWER created $_pdfPath");
                // Use the pdfViewController to interact with the PDF
              },
            ),
    );
  }
}
