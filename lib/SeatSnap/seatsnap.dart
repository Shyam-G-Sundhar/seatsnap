import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seatsnap/HallSpot/hallbook.dart';
import 'package:seatsnap/home.dart';
import 'package:seatsnap/main.dart';

class SeatSnap extends StatefulWidget {
  const SeatSnap({Key? key});

  @override
  State<SeatSnap> createState() => _SeatSnapState();
}

class _SeatSnapState extends State<SeatSnap> {
  final clr = const Color(0xff0B1F5B);
  late GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
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
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double maxWidth = constraints.maxWidth;
          final bool isDesktop = maxWidth >= 900;
          final double containerWidth = isDesktop ? 370 : maxWidth * 0.8;
          final double spacing = isDesktop ? 95 : 0;

          Widget buildContainer(Color clr2, name, seatCount, seatsPerRow) {
            return Container(
              decoration: BoxDecoration(
                color: clr,
                borderRadius: BorderRadius.circular(25),
              ),
              height: isDesktop ? 290 : 180,
              width: containerWidth,
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              height: 200,
                              alignment: Alignment.center,
                              width: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: clr2,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => HallBook(
                                              name: name,
                                              seatCount: seatCount,
                                              seatsPerRow: seatsPerRow,
                                            )),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(250, 40),
                                    backgroundColor: Colors.white,
                                    side: BorderSide.none,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25))),
                                child: Text(
                                  'Book Now',
                                  style: GoogleFonts.reemKufi(
                                      fontSize: 25,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return SingleChildScrollView(
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 45, vertical: 45),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        buildContainer(Colors.red, 'Hall 1', 200, 20),
                        SizedBox(width: spacing),
                        if (isDesktop)
                          buildContainer(Colors.blue, 'Hall 2', 500, 25)
                      ],
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        buildContainer(Colors.green, 'Hall 3', 700, 35),
                        SizedBox(width: spacing),
                        if (isDesktop)
                          buildContainer(Colors.yellow, 'Hall 4', 35, 7)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
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
                          builder: (context) =>
                              const MyHomePage(title: 'MyNest'),
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
    );
  }

  Widget lsttle(
    String title,
    IconData leadingIcon,
    IconData trailingIcon,
    VoidCallback onTap,
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
