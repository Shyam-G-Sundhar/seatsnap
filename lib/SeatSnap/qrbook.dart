import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../home.dart';
import '../main.dart';

import 'package:flutter/rendering.dart';

class QRBook extends StatefulWidget {
  QRBook({Key? key, required this.qrstr, required this.hall}) : super(key: key);

  final qrstr;
  final hall;

  @override
  State<QRBook> createState() => _QRBookState();
}

class _QRBookState extends State<QRBook> {
  Uint8List? imageBytes;

  final clr = const Color(0xff0B1F5B);
  late GlobalKey<ScaffoldState> _scaffoldKey;
  GlobalKey globalKey = GlobalKey();
  bool isLoading = false;
  String qrData = "";
  final _screenshotController = ScreenshotController();
  String hall = "";

  void _takeScreenshot() async {
    final uint8List = await _screenshotController.capture();
    String tempPath = (await getTemporaryDirectory()).path;
    String fileName = "screen";
    File file = await File('$tempPath/$fileName.png').create();
    await file.writeAsBytes(uint8List!);
  }

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    qrData = widget.qrstr;
    hall = widget.hall;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          child: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xff0B1F5B),
        title: Text(
          'MyNest',
          style: GoogleFonts.reemKufi(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double maxWidth = constraints.maxWidth;
          final bool isDesktop = maxWidth >= 900;

          return FractionallySizedBox(
            alignment: Alignment.center,
            widthFactor: isDesktop ? null : 0.8,
            child: Drawer(
              backgroundColor: clr,
              child: ListView(
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Text(
                      'XXXX',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.reemKufi(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Text(
                      '123@xyz.in',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.reemKufi(
                        color: Colors.white,
                        fontSize: 20,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  lsttle(
                    'SeatSnap',
                    Icons.airline_seat_recline_normal,
                    Icons.chevron_left,
                    () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => MainHome(
                                  username: '123456',
                                  password: '123456',
                                )),
                        (route) => false,
                      );
                    },
                  ),
                  const SizedBox(height: 25),
                  lsttle(
                    'LogOut',
                    Icons.logout,
                    Icons.chevron_right,
                    () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => MyHomePage(title: 'MyNest'),
                        ),
                        (route) => false,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Container(
                              height: 300,
                              width: 300,
                              decoration: BoxDecoration(
                                color: clr,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Center(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 250,
                                      height: 250,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Column(
                                        children: [],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Text(
                              hall.isNotEmpty ? hall : '',
                              style: GoogleFonts.reemKufi(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: isLoading
                            ? CircularProgressIndicator()
                            : Screenshot(
                                controller: _screenshotController,
                                child: RepaintBoundary(
                                  key: globalKey,
                                  child: Container(
                                    width: 550,
                                    height: 550,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: clr, width: 5),
                                      borderRadius: BorderRadius.circular(45),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        qrData.isEmpty
                                            ? Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: clr,
                                                  strokeWidth: 5,
                                                ),
                                              )
                                            : QrImageView(
                                                data: qrData,
                                                size: 250,
                                              ),
                                        ElevatedButton(
                                          onPressed: () {
                                            _takeScreenshot();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: clr,
                                            fixedSize: Size(350, 50),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                          ),
                                          child: Text(
                                            "Download Your Seat",
                                            style: GoogleFonts.reemKufi(
                                              fontSize: 25,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          'Enjoy Your Event!',
                                          style: GoogleFonts.reemKufi(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget lsttle(
    String title,
    IconData leadingIcon,
    IconData trailingIcon,
    onTap,
  ) {
    return ListTile(
      titleAlignment: ListTileTitleAlignment.center,
      trailing: Icon(
        trailingIcon,
        size: 35,
        color: Colors.white,
      ),
      leading: Icon(
        leadingIcon,
        size: 35,
        color: Colors.white,
      ),
      title: Text(
        title,
        style: GoogleFonts.reemKufi(
          color: Colors.white,
          fontSize: 24,
        ),
      ),
      onTap: onTap,
    );
  }
}
