import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seatsnap/main.dart';
import 'package:seatsnap/SeatSnap/qrbook.dart';
import 'package:intl/intl.dart';
import '../home.dart';

class HallBook extends StatefulWidget {
  HallBook({
    super.key,
    required this.name,
    required this.seatCount,
    required this.seatsPerRow,
  });

  final name, seatCount, seatsPerRow;

  @override
  State<HallBook> createState() => _HallBookState();
}

class Hall {
  final String name;
  final int seatCount;
  final int seatsPerRow;

  Hall({
    required this.name,
    required this.seatCount,
    required this.seatsPerRow,
  });
}

class _HallBookState extends State<HallBook> {
  final _formKey = GlobalKey<FormState>();
  final clr = const Color(0xff0B1F5B);
  late GlobalKey<ScaffoldState> _scaffoldKey;
  final _nameController = TextEditingController();
  final _rollNoController = TextEditingController();
  String? _selectedHall;
  String? _selectedSeat;
  String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String currentTime = DateFormat('HH:mm:ss').format(DateTime.now());
  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    halls = [
      Hall(
        name: widget.name,
        seatCount: widget.seatCount,
        seatsPerRow: widget.seatsPerRow,
      ),
    ];
  }

  List<Hall> halls = [];

  @override
  void dispose() {
    _nameController.dispose();
    _rollNoController.dispose();
    super.dispose();
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
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
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        widget.name,
                        style: GoogleFonts.reemKufi(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                //Hall Book Starts
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Form(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Enter Details',
                                  style: GoogleFonts.reemKufi(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: _nameController,
                                  autocorrect: true,
                                  decoration: const InputDecoration(
                                    labelText: 'Name',
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your name';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: _rollNoController,
                                  decoration: const InputDecoration(
                                    labelText: 'Roll No',
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your roll no';
                                    }
                                    return null;
                                  },
                                ),
                                DropdownButtonFormField<String>(
                                  value: _selectedHall,
                                  decoration: const InputDecoration(
                                    labelText: 'Select Hall',
                                  ),
                                  items: halls.map((hall) {
                                    return DropdownMenuItem<String>(
                                      value: hall.name,
                                      child: Text(hall.name),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedHall = value;
                                      _selectedSeat = null;
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please select a hall';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 16),
                                if (_selectedHall != null)
                                  SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Select Seat:',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 16),
                                        GridView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: halls
                                                .firstWhere((hall) =>
                                                    hall.name == _selectedHall)
                                                .seatsPerRow,
                                            crossAxisSpacing: 8,
                                            mainAxisSpacing: 8,
                                          ),
                                          itemCount: halls
                                              .firstWhere((hall) =>
                                                  hall.name == _selectedHall)
                                              .seatCount,
                                          itemBuilder: (context, index) {
                                            int row = index ~/
                                                halls
                                                    .firstWhere((hall) =>
                                                        hall.name ==
                                                        _selectedHall)
                                                    .seatsPerRow;
                                            int seat = index %
                                                halls
                                                    .firstWhere((hall) =>
                                                        hall.name ==
                                                        _selectedHall)
                                                    .seatsPerRow;
                                            String seatLabel =
                                                String.fromCharCode(65 + row) +
                                                    (seat + 1).toString();
                                            final isSelected =
                                                _selectedSeat == seatLabel;
                                            return GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _selectedSeat = isSelected
                                                      ? null
                                                      : seatLabel;
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: isSelected
                                                      ? Colors.green
                                                      : Colors.grey,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    seatLabel,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight: isSelected
                                                          ? FontWeight.bold
                                                          : FontWeight.normal,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      if (_selectedSeat == null) {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('No Seat Selected'),
                                              content:
                                                  Text('Please select a seat.'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('OK'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      } else {
                                        // Perform booking logic here
                                        final name = _nameController.text;
                                        final rollNo = _rollNoController.text;
                                        final hall = _selectedHall;
                                        final seat = _selectedSeat;

                                        // You can proceed with the booking logic or display a success message
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Dialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25)),
                                              child: Container(
                                                alignment: Alignment.topCenter,
                                                width: 550,
                                                height: 450,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: clr,
                                                      width: 3,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'MyNest Booking',
                                                        style: GoogleFonts
                                                            .reemKufi(
                                                                fontSize: 55,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        25),
                                                            color: clr),
                                                        alignment:
                                                            Alignment.center,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                                'Name:     $name',
                                                                style: GoogleFonts.reemKufi(
                                                                    fontSize:
                                                                        25,
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                            const SizedBox(
                                                              height: 15,
                                                            ),
                                                            Text(
                                                                'Roll No:     $rollNo',
                                                                style: GoogleFonts.reemKufi(
                                                                    fontSize:
                                                                        25,
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                            const SizedBox(
                                                              height: 15,
                                                            ),
                                                            Text(
                                                                'Hall:     $hall',
                                                                style: GoogleFonts.reemKufi(
                                                                    fontSize:
                                                                        25,
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                            const SizedBox(
                                                              height: 15,
                                                            ),
                                                            Text(
                                                                'Seat:     $seat',
                                                                style: GoogleFonts.reemKufi(
                                                                    fontSize:
                                                                        25,
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          'Would you Like To Confirm ?',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: GoogleFonts
                                                              .reemKufi(
                                                                  fontSize: 30,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      Container(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            ElevatedButton(
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              25)),
                                                                  backgroundColor:
                                                                      Colors
                                                                          .white,
                                                                  side: BorderSide(
                                                                      color:
                                                                          clr,
                                                                      width: 2),
                                                                ),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child: Text(
                                                                  'No',
                                                                  style: GoogleFonts.reemKufi(
                                                                      fontSize:
                                                                          25,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color:
                                                                          clr),
                                                                )),
                                                            ElevatedButton(
                                                                style: ElevatedButton.styleFrom(
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                25)),
                                                                    backgroundColor:
                                                                        clr,
                                                                    side: BorderSide(
                                                                        color: Colors
                                                                            .white,
                                                                        width:
                                                                            2)),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pushAndRemoveUntil(
                                                                          MaterialPageRoute(
                                                                              builder: (context) =>
                                                                                  QRBook(
                                                                                    qrstr: 'Clg: XYZ, Hall: $hall, Name: $name, RollNo: $rollNo, Seat: $seat, BookingDate: $currentDate, BookingTime: $currentTime',
                                                                                    hall: hall,
                                                                                  )),
                                                                          (route) =>
                                                                              false);
                                                                },
                                                                child: Text(
                                                                  'Confirm',
                                                                  style: GoogleFonts.reemKufi(
                                                                      fontSize:
                                                                          25,
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                )),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }
                                    }
                                  },
                                  child: Text('Submit'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
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
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      onTap: onTap,
    );
  }
}
