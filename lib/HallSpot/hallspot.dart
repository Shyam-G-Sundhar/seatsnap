import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:seatsnap/home.dart';
import 'package:seatsnap/main.dart';
import 'package:seatsnap/SeatSnap/seatsnap.dart';

class HallSpot extends StatefulWidget {
  const HallSpot({Key? key, required this.username}) : super(key: key);
  final username;

  @override
  State<HallSpot> createState() => _HallSpotState();
}

class _HallSpotState extends State<HallSpot> {
  final clr = const Color(0xff0B1F5B);
  late GlobalKey<ScaffoldState> _scaffoldKey;
  File? _selectedImage;
  final _formKey = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? selectedHall;
  List<String> hallOptions = ['Hall 1', 'Hall 2', 'Hall 3', 'Hall 4', 'Hall 5'];
  List<String> subjects = [
    'AD', 'AM', 'CS', 'CE', 'CH', 'ME', 'ECE', 'EEE', 'MH', 'CSBS', 'BME', 'IT',
    'VLSI'
    // Add more subjects here
  ];
  String selectedOption = 'Select';
  List<String> options = ['Select', 'Option 1', 'Option 2', 'Option 3'];
  List<bool> isSelectedList = List.generate(15, (_) => false);
  DateTime selectedFromDate = DateTime.now();
  DateTime selectedToDate = DateTime.now();
  Future<void> _showDateTimePicker(bool isFromDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isFromDate ? selectedFromDate : selectedToDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(
            isFromDate ? selectedFromDate : selectedToDate),
      );

      if (pickedTime != null) {
        final DateTime selectedDateTime = DateTime(
          picked.year,
          picked.month,
          picked.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          if (isFromDate) {
            selectedFromDate = selectedDateTime;
          } else {
            selectedToDate = selectedDateTime;
          }
        });
      }
    }
  }

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (formKey.currentState!.validate()) {
        isSelectedList = List.generate(15, (_) => false);
        String selectedFromDateString =
            DateFormat('dd-MM-yyyy  -  hh:mm   a').format(selectedFromDate);

        String selectedToDateString =
            DateFormat('dd-MM-yyyy  -  hh:mm   a').format(selectedToDate);

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              child: Container(
                alignment: Alignment.topCenter,
                width: 550,
                height: 450,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: clr,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(25)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'MyNest Booking',
                        style: GoogleFonts.reemKufi(
                            fontSize: 55, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: clr),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Title:     ${_titleController.text}',
                                style: GoogleFonts.reemKufi(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(
                              height: 15,
                            ),
                            Text('Roll No:     ${_descriptionController.text}',
                                style: GoogleFonts.reemKufi(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(
                              height: 15,
                            ),
                            Text('Hall:     $selectedHall',
                                style: GoogleFonts.reemKufi(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('From:     $selectedFromDateString',
                                      style: GoogleFonts.reemKufi(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Text('To:     $selectedToDateString',
                                      style: GoogleFonts.reemKufi(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Would you Like To Confirm ?',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.reemKufi(
                              fontSize: 30, fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                  backgroundColor: Colors.white,
                                  side: BorderSide(color: clr, width: 2),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'No',
                                  style: GoogleFonts.reemKufi(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: clr),
                                )),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    backgroundColor: clr,
                                    side: const BorderSide(
                                        color: Colors.white, width: 2)),
                                onPressed: () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ConfirmHallBook()),
                                      (route) => false);
                                },
                                child: Text(
                                  'Confirm',
                                  style: GoogleFonts.reemKufi(
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
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
  }

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
            //  final double drawerWidth = isDesktop ? 300 : maxWidth * 0.8;

            return FractionallySizedBox(
              alignment: Alignment.center,
              widthFactor: isDesktop ? null : 0.8,
              child: Drawer(
                backgroundColor: clr,
                child: ListView(
                  children: [
                    DrawerHeader(
                      decoration: const BoxDecoration(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircleAvatar(
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
                            color: Colors.white, fontSize: 25),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Text(
                        '123@xyz.in',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.reemKufi(
                            color: Colors.white,
                            fontSize: 20,
                            letterSpacing: 2.0),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    lsttle('SeatSnap', Icons.airline_seat_recline_normal, () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => SeatSnap()),
                          (route) => false);
                    }),
                    SizedBox(
                      height: 15,
                    ),
                    widget.username == '123456'
                        ? (lsttle('HallSpot', Icons.meeting_room, () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => HallSpot(
                                          username: widget.username,
                                        )),
                                (route) => false);
                          }))
                        : SizedBox(
                            height: 10,
                          ),
                    SizedBox(
                      height: 10,
                    ),
                    lsttle('LogOut', Icons.logout, () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) =>
                                  MyHomePage(title: 'MyNest')),
                          (route) => false);
                    }),
                  ],
                ),
              ),
            );
          },
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 35),
                child: Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: _selectImage,
                          child: Container(
                            height: 300,
                            width: constraints.maxWidth < 600
                                ? double.infinity
                                : 300,
                            decoration: BoxDecoration(
                              border: Border.all(color: clr, width: 10),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: _selectedImage != null
                                ? Image.file(
                                    _selectedImage!,
                                    fit: BoxFit.cover,
                                  )
                                : const Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.image,
                                          size: 100,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'Tap to upload image',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                        if (constraints.maxWidth >= 600)
                          const SizedBox(width: 48),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: _titleController,
                                    autocorrect: true,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Title',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter Title';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    controller: _descriptionController,
                                    autocorrect: true,
                                    maxLength: 60,
                                    maxLines: null,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Description',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter Description';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 15),
                                  DropdownButtonFormField<String>(
                                    decoration: const InputDecoration(
                                      labelText: 'Select a Hall',
                                      border: OutlineInputBorder(),
                                    ),
                                    value: selectedHall,
                                    items: hallOptions.map((hall) {
                                      return DropdownMenuItem<String>(
                                        value: hall,
                                        child: Text(hall),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedHall = value;
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Please select a hall';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 25),
                                  Row(
                                    children: [
                                      Text(
                                        'From:',
                                        style: GoogleFonts.reemKufi(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25.0,
                                        ),
                                      ),
                                      const SizedBox(width: 25),
                                      InkWell(
                                        onTap: () => _showDateTimePicker(true),
                                        child: Text(
                                          DateFormat('dd-MM-yyyy  -  hh:mm   a')
                                              .format(selectedFromDate),
                                          style: GoogleFonts.reemKufi(
                                            fontSize: 30,
                                            color: clr,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 55),
                                      Text(
                                        'To:',
                                        style: GoogleFonts.reemKufi(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25.0,
                                        ),
                                      ),
                                      const SizedBox(width: 25),
                                      InkWell(
                                        onTap: () => _showDateTimePicker(false),
                                        child: Text(
                                          DateFormat('dd-MM-yyyy  -  hh:mm   a')
                                              .format(selectedToDate),
                                          style: GoogleFonts.reemKufi(
                                            fontSize: 30,
                                            color: clr,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 25),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(15.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          color: Colors.grey.shade300,
                                        ),
                                        width: constraints.maxWidth < 600
                                            ? double.infinity
                                            : 600,
                                        height: 100,
                                        child: Wrap(
                                          spacing: 12.0,
                                          runSpacing: 12.0,
                                          children: subjects.map((subject) {
                                            final index =
                                                subjects.indexOf(subject);
                                            return FilterChip(
                                              elevation: 3,
                                              pressElevation: 5,
                                              showCheckmark: true,
                                              checkmarkColor: Colors.white,
                                              side: BorderSide(
                                                  color: clr, width: 2),
                                              label: Text(subject),
                                              labelStyle: GoogleFonts.reemKufi(
                                                color: isSelectedList[index]
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                              selected: isSelectedList[index],
                                              selectedColor: clr,
                                              onSelected: (bool selected) {
                                                setState(() {
                                                  isSelectedList[index] =
                                                      selected;
                                                });
                                              },
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      const SizedBox(width: 25),
                                      LayoutBuilder(
                                        builder: (BuildContext context,
                                            BoxConstraints constraints) {
                                          return SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: SingleChildScrollView(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  border: Border.all(
                                                      color: clr, width: 5),
                                                ),
                                                height:
                                                    constraints.maxWidth < 600
                                                        ? null
                                                        : 250,
                                                width:
                                                    constraints.maxWidth < 600
                                                        ? double.infinity
                                                        : 300,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      20.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        'How many members from each class?',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts
                                                            .reemKufi(
                                                          fontSize: 24,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 15),
                                                      Form(
                                                        key: formKey,
                                                        child: Container(
                                                          width: 200,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12.0),
                                                            border: Border.all(
                                                              color: clr,
                                                              width: 3,
                                                            ),
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      16.0),
                                                          child:
                                                              DropdownButtonHideUnderline(
                                                            child:
                                                                DropdownButton<
                                                                    String>(
                                                              value:
                                                                  selectedOption,
                                                              onChanged: (String?
                                                                  newValue) {
                                                                setState(() {
                                                                  selectedOption =
                                                                      newValue!;
                                                                });
                                                              },
                                                              items: options.map<
                                                                  DropdownMenuItem<
                                                                      String>>((String
                                                                  value) {
                                                                return DropdownMenuItem<
                                                                    String>(
                                                                  value: value,
                                                                  child: Text(
                                                                    value,
                                                                    style: GoogleFonts
                                                                        .reemKufi(
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                    ),
                                                                  ),
                                                                );
                                                              }).toList(),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 25),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _submitForm();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: clr,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                        'Submit',
                        style: GoogleFonts.reemKufi(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget lsttle(String title, IconData leadingIcon, Function onTap) {
  return ListTile(
    titleAlignment: ListTileTitleAlignment.center,
    trailing: Icon(
      Icons.chevron_right,
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
      style: GoogleFonts.reemKufi(color: Colors.white, fontSize: 24),
    ),
    onTap: () {
      onTap();
    },
  );
}

class ConfirmHallBook extends StatefulWidget {
  const ConfirmHallBook({super.key});

  @override
  State<ConfirmHallBook> createState() => _ConfirmHallBookState();
}

class _ConfirmHallBookState extends State<ConfirmHallBook> {
  final clr = const Color(0xff0B1F5B);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) =>
                  MainHome(username: '123456', password: '123456')),
          (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0B1F5B),
        title: Text(
          'MyNest',
          style: GoogleFonts.reemKufi(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Your Hall is Booked !!!',
                style: GoogleFonts.reemKufi(
                    fontSize: 25, fontWeight: FontWeight.bold, color: clr),
              )
            ],
          ),
        ),
      ),
    );
  }
}
