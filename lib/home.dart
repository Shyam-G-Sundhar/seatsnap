import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:js' as js;
import 'package:google_fonts/google_fonts.dart';
import 'package:seatsnap/HallSpot/hallspot.dart';
import 'package:seatsnap/main.dart';
import 'package:seatsnap/SeatSnap/seatsnap.dart';
import 'package:timelines/timelines.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:video_player/video_player.dart';

class MainHome extends StatefulWidget {
  MainHome({Key? key, required this.username, required this.password});
  final username, password;
  @override
  State<MainHome> createState() => _MainHomeState();
}

class TimelineEvent {
  final String title;
  final String description;
  final DateTime dateTime;

  TimelineEvent(this.title, this.description, this.dateTime);
}

class _MainHomeState extends State<MainHome> {
  final clr = const Color(0xff0B1F5B);
  late GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    controller = VideoPlayerController.networkUrl(Uri.parse(
        'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4'));
    _playbackicon = Icons.play_arrow;
    _initializeVideoPlayer();
  }

  late VideoPlayerController controller;
  late IconData _playbackicon;
  bool _isFullScreen = false;

  Future<void> _initializeVideoPlayer() async {
    await controller.initialize();
    if (mounted) {
      setState(() {});
    }
  }

  List<String> videoUrls = [
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    'https://www.example.com/video3.mp4',
    'https://www.example.com/video1.mp4',
    'https://www.example.com/video2.mp4',
    'https://www.example.com/video3.mp4',
    'https://www.example.com/video1.mp4',
    'https://www.example.com/video2.mp4',
    'https://www.example.com/video3.mp4',
    'https://www.example.com/video1.mp4',
    'https://www.example.com/video2.mp4',
    'https://www.example.com/video3.mp4',
  ];

  final List<TimelineEvent> events = [
    TimelineEvent("Event 3", "Description for Event 3", DateTime(2023, 7, 10)),
    TimelineEvent("Event 1", "Description for Event 1", DateTime(2023, 1, 15)),
    TimelineEvent("Event 2", "Description for Event 2", DateTime(2023, 4, 25)),
    TimelineEvent("Event 3", "Description for Event 3", DateTime(2023, 7, 10)),
    TimelineEvent("Event 1", "Description for Event 1", DateTime(2023, 1, 15)),
    TimelineEvent("Event 2", "Description for Event 2", DateTime(2023, 4, 25)),
    TimelineEvent("Event 3", "Description for Event 3", DateTime(2023, 7, 10)),
    TimelineEvent("Event 1", "Description for Event 1", DateTime(2023, 1, 15)),
    TimelineEvent("Event 2", "Description for Event 2", DateTime(2023, 4, 25)),
    TimelineEvent("Event 3", "Description for Event 3", DateTime(2023, 7, 10)),
    TimelineEvent("Event 1", "Description for Event 1", DateTime(2023, 1, 15)),
    TimelineEvent("Event 2", "Description for Event 2", DateTime(2023, 4, 25)),
    // Add more events as needed
  ];

  final ScrollController _scrollController = ScrollController();

  void _scrollRight() {
    _scrollController.animateTo(
      _scrollController.offset + 300, // Adjust the value for scrolling distance
      curve: Curves.easeInOut,
      duration: Duration(milliseconds: 300),
    );
  }

  void _playPause() {
    if (controller.value.isPlaying) {
      controller.pause();
      _playbackicon = Icons.play_arrow;
    } else {
      controller.play();
      _playbackicon = Icons.pause;
    }
    setState(() {});
  }

  void _openFullScreenDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: FullScreenVideoWidget(controller: controller),
        );
      },
    ).then((value) {
      setState(() {});
    });
  }

  void _scrollLeft() {
    _scrollController.animateTo(
      _scrollController.offset - 300, // Adjust the value for scrolling distance
      curve: Curves.easeInOut,
      duration: Duration(milliseconds: 300),
    );
  }

  bool showImage = true;
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
      body: SingleChildScrollView(
        child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: 380,
                    height: 280,
                    decoration: BoxDecoration(
                      color: clr,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: Container(
                                  width: 300,
                                  height: 225,
                                  decoration: BoxDecoration(
                                      color: showImage
                                          ? Colors.white
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                    child: Stack(
                                      children: [
                                        if (showImage)
                                          Image.network(
                                              'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerBlazes.jpg')
                                        else
                                          GestureDetector(
                                            onTap: _playPause,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: controller
                                                      .value.isInitialized
                                                  ? Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25)),
                                                          child: AspectRatio(
                                                            aspectRatio: 14 / 9,
                                                            child: VideoPlayer(
                                                                controller),
                                                          ),
                                                        ),
                                                        IconButton(
                                                          icon: Icon(
                                                            _playbackicon,
                                                            color: Colors.white,
                                                          ),
                                                          iconSize: 32,
                                                          onPressed: _playPause,
                                                        ),
                                                        Positioned(
                                                          right: 0,
                                                          child: IconButton(
                                                            icon: Icon(
                                                              _isFullScreen
                                                                  ? Icons
                                                                      .fullscreen_exit
                                                                  : Icons
                                                                      .fullscreen,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            onPressed:
                                                                _openFullScreenDialog,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: clr,
                                                      ),
                                                    ),
                                            ),
                                          ),
                                        // Replace with your image asset path
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                FloatingActionButton(
                                  backgroundColor: Colors.white,
                                  onPressed: () {
                                    setState(() {
                                      showImage = true;
                                    });
                                  },
                                  child: Icon(
                                    Icons.image,
                                    color: clr,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                FloatingActionButton(
                                  backgroundColor: Colors.white,
                                  onPressed: () {
                                    setState(() {
                                      showImage = false;
                                    });
                                  },
                                  child: Icon(
                                    Icons.play_arrow,
                                    color: clr,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      width: 600,
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide()),
                      ),
                      child: Text(
                        'Agenda',
                        style: GoogleFonts.reemKufi(
                          fontSize: 35,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 170,
                      width: 550,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment:
                                CrossAxisAlignment.center, // Adjusted alignment
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AgendaElem(
                                iconname: Icons.mail,
                                iconsize: 35,
                                icondes: 'abc@xyz.com',
                              ),
                              AgendaElem(
                                iconname: Icons.person,
                                iconsize: 35,
                                icondes: 'Gender',
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment:
                                CrossAxisAlignment.center, // Adjusted alignment
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AgendaElem(
                                iconname: Icons.call,
                                iconsize: 35,
                                icondes: '+00-1234567890',
                              ),
                              AgendaElem(
                                iconname: Icons.radio_button_unchecked,
                                iconsize: 35,
                                icondes: 'Status',
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment:
                                CrossAxisAlignment.center, // Adjusted alignment
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AgendaElem(
                                iconname: Icons.cake,
                                iconsize: 35,
                                icondes: '00-00-00',
                              ),
                              AgendaElem(
                                iconname: Icons.location_on,
                                iconsize: 35,
                                icondes: 'xxxx,yyyy',
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      child: Container(
                        decoration: BoxDecoration(
                            color: clr,
                            borderRadius: BorderRadius.circular(20)),
                        width: 570,
                        height: 48,
                        padding: const EdgeInsets.all(5),
                        child: const Stack(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SocialMediaIcons(
                                  url: 'www.linkedin.com',
                                  imgurl: 'assets/linkedin.png',
                                ),
                                SocialMediaIcons(
                                  url: 'www.threads.net',
                                  imgurl: 'assets/threads.png',
                                ),
                                SocialMediaIcons(
                                  url: 'www.gmail.com',
                                  imgurl: 'assets/gmail.png',
                                ),
                                SocialMediaIcons(
                                  url: 'www.facebook.com',
                                  imgurl: 'assets/Facebook.png',
                                ),
                                SocialMediaIcons(
                                  url: 'www.instagram.com',
                                  imgurl: 'assets/Instagram.png',
                                ),
                                SocialMediaIcons(
                                  url: 'www.twitter.com',
                                  imgurl: 'assets/TwitterX.png',
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ]),
              const SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 600,
                          decoration: const BoxDecoration(
                            border: Border(bottom: BorderSide()),
                          ),
                          child: Text(
                            'Profile Info',
                            style: GoogleFonts.reemKufi(
                                fontSize: 35, fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        SizedBox(
                          width: 550,
                          child: Column(
                            children: [
                              ProfileInfo(
                                clr: clr,
                                icontitle: 'Current Position',
                                icondes: 'XXXXX',
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              ProfileInfo(
                                clr: clr,
                                icontitle: 'Highest Qualification',
                                icondes: 'YYYYY',
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              ProfileInfo(
                                clr: clr,
                                icontitle: 'Prefered Location',
                                icondes: 'xxxx,yyyy',
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              ProfileInfo(
                                clr: clr,
                                icontitle: 'Area Of Interest',
                                icondes: 'ZZZZZ',
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 65,
                      ),
                      Container(
                        width: 600,
                        decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide()),
                        ),
                        child: Text(
                          'Expertise',
                          style: GoogleFonts.reemKufi(
                            fontSize: 35,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Align(
                        child: SizedBox(
                          width: 600,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  ExpertiseElement(
                                    clr: clr,
                                    icondesp: 'Skills',
                                    countvalue: 1,
                                  ),
                                  ExpertiseElement(
                                    clr: clr,
                                    icondesp: 'Certificates',
                                    countvalue: 2,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  ExpertiseElement(
                                    clr: clr,
                                    icondesp: 'Project(s)',
                                    countvalue: 3,
                                  ),
                                  ExpertiseElement(
                                    clr: clr,
                                    icondesp: 'Acheivements',
                                    countvalue: 4,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  ExpertiseElement(
                                    clr: clr,
                                    icondesp: 'Languages',
                                    countvalue: 5,
                                  ),
                                  ExpertiseElement(
                                    clr: clr,
                                    icondesp: 'Hobbies',
                                    countvalue: 6,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  ExpertiseElement(
                                    clr: clr,
                                    icondesp: 'Goals',
                                    countvalue: 7,
                                  ),
                                  ExpertiseElement(
                                    clr: clr,
                                    icondesp: 'Core \nCompentencies',
                                    countvalue: 8,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 600,
                          decoration: const BoxDecoration(
                            border: Border(bottom: BorderSide()),
                          ),
                          child: Text(
                            'Timeline',
                            style: GoogleFonts.reemKufi(
                              fontSize: 35,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: 500,
                            height: 200,
                            child: Timeline.tileBuilder(
                              theme: TimelineThemeData(
                                direction: Axis.vertical,
                                connectorTheme: ConnectorThemeData(
                                  space: 30.0,
                                  thickness: 3.0,
                                ),
                              ),
                              builder: TimelineTileBuilder.connected(
                                connectionDirection: ConnectionDirection.before,
                                itemCount: events.length,
                                contentsBuilder: (context, index) {
                                  final event = events[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${event.dateTime.year}-${event.dateTime.month}-${event.dateTime.day}',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 8),
                                        Text(event.title),
                                        SizedBox(height: 8),
                                        Text(event.description),
                                      ],
                                    ),
                                  );
                                },
                                connectorBuilder: (_, index, type) {
                                  return SolidLineConnector(
                                    color: Colors.black,
                                    thickness: 4.0,
                                  );
                                },
                                indicatorBuilder: (_, index) {
                                  // final event = events[index];
                                  return Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    child: DotIndicator(
                                      size: 25,
                                      color: clr,
                                      child: Text(
                                        '',
                                        //                                      '${event.dateTime.month}/${event.dateTime.year}',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ]),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Container(
                      width: 600,
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide()),
                      ),
                      child: Text(
                        'Placement Pie',
                        style: GoogleFonts.reemKufi(
                          fontSize: 35,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 300,
                          height: 300,
                          child: DonutChart(dataValue: 340 / 360),
                        ),
                        Container(
                          width: 300,
                          height: 300,
                          child: HorizontalBarChart(data: {
                            'Sem 1': 100,
                            'Sem 2': 80,
                            'Sem 3': 40,
                            'Sem 4': 45,
                            'Sem 5': 74,
                            'Sem 6': 45,
                            'Sem 7': 87,
                            'Sem 8': 14,
                          }),
                        ),
                      ],
                    ),
                  ],
                )
              ]),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45.0),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide()),
                      ),
                      child: Text(
                        'Endorsement',
                        style: GoogleFonts.reemKufi(
                          fontSize: 35,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      height: 220,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: clr,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 45, vertical: 15),
                            child: ListView.builder(
                                itemCount: videoUrls.length,
                                controller: _scrollController,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return VideoContainer(
                                      videoUrl: videoUrls[index]);
                                }),
                          ),
                          Positioned(
                            left: 0,
                            top: 0,
                            bottom: 0,
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              onPressed: _scrollLeft,
                            ),
                          ),
                          Positioned(
                              right: 0,
                              top: 0,
                              bottom: 0,
                              child: IconButton(
                                icon: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                ),
                                onPressed: _scrollRight,
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              )
            ])),
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
                  const SizedBox(
                    height: 25,
                  ),
                  lsttle('SeatSnap', Icons.airline_seat_recline_normal, () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const SeatSnap()),
                        (route) => false);
                  }),
                  const SizedBox(
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
                      : const SizedBox(
                          height: 10,
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  lsttle('LogOut', Icons.logout, () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) =>
                                const MyHomePage(title: 'MyNest')),
                        (route) => false);
                  }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget lsttle(String title, IconData leadingIcon, Function onTap) {
    return ListTile(
      titleAlignment: ListTileTitleAlignment.center,
      trailing: const Icon(
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
}

class ExpertiseElement extends StatefulWidget {
  ExpertiseElement({
    super.key,
    required this.clr,
    this.countvalue,
    this.icondesp,
  });
  final countvalue, icondesp;
  final Color clr;

  @override
  State<ExpertiseElement> createState() => _ExpertiseElementState();
}

class _ExpertiseElementState extends State<ExpertiseElement> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double containerWidth =
            constraints.maxWidth > 290 ? 299 : constraints.maxWidth;

        return SizedBox(
          width: containerWidth,
          child: Card(
            child: ExpansionTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                        color: widget.clr,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Stack(
                        children: [
                          Text(
                            '${widget.countvalue}',
                            style: GoogleFonts.reemKufi(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    '${widget.icondesp}',
                    style: GoogleFonts.reemKufi(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  )
                ],
              ),
              children: [
                ListTile(
                  title: Text('Details for User'),
                  subtitle: Text('More information about User'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ProfileInfo extends StatefulWidget {
  final iconname, icontitle, icondes;
  const ProfileInfo({
    super.key,
    required this.clr,
    this.iconname,
    this.icontitle,
    this.icondes,
  });

  final Color clr;

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  @override
  Widget build(BuildContext context) {
    return Align(
      child: Row(
        children: [
          Icon(
            Icons.zoom_out_sharp,
            color: Colors.black,
            size: 45,
          ),
          SizedBox(
            width: 55,
          ),
          Column(
            children: [
              Text(
                widget.icontitle,
                style: GoogleFonts.reemKufi(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              Text(
                widget.icondes,
                style: GoogleFonts.reemKufi(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: widget.clr),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class SocialMediaIcons extends StatefulWidget {
  final url, imgurl;
  const SocialMediaIcons({
    super.key,
    this.url,
    this.imgurl,
  });

  @override
  State<SocialMediaIcons> createState() => _SocialMediaIconsState();
}

class _SocialMediaIconsState extends State<SocialMediaIcons> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: Colors.white,
      onPressed: () {
        final url = 'https://${widget.url}'; // Replace with your desired URL
        js.context.callMethod('open', [url, '_blank']);
      },
      icon: Image.asset('${widget.imgurl}'),
    );
  }
}

class AgendaElem extends StatefulWidget {
  final icondes;
  final IconData iconname;
  final double iconsize;
  AgendaElem({
    super.key,
    required this.iconname,
    this.icondes,
    required this.iconsize,
  });

  @override
  State<AgendaElem> createState() => _AgendaElemState();
}

class _AgendaElemState extends State<AgendaElem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          widget.iconname,
          size: widget.iconsize,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          widget.icondes,
          style:
              GoogleFonts.reemKufi(fontSize: 18, fontWeight: FontWeight.w700),
        )
      ],
    );
  }
}

/*
  Center(
        child: Container(
          width: 200,
          height: 200,
          color: showImage ? Colors.yellow : Colors.white,
          child: Stack(
            children: [
              if (showImage) Text('Image') else Text('Video'),
              // Replace with your image asset path
              Align(
                alignment: Alignment.topRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          showImage = true;
                        });
                      },
                      child: Icon(Icons.image),
                    ),
                    SizedBox(width: 10),
                    FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          showImage = false;
                        });
                      },
                      child: Icon(Icons.color_lens),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),*/
class DonutChart extends StatefulWidget {
  final double dataValue;

  const DonutChart({super.key, required this.dataValue});

  @override
  State<DonutChart> createState() => _DonutChartState();
}

class _DonutChartState extends State<DonutChart> {
  final Color clr = const Color(0xff0B1F5B);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        PieChart(
          PieChartData(
            sections: [
              PieChartSectionData(
                value: widget.dataValue,
                color: clr,
                titlePositionPercentageOffset: 0.5, // Center the title
                radius: 70, // Adjust the radius thickness
                title: '',
              ),
              PieChartSectionData(
                value: 1 - widget.dataValue,
                color: Colors
                    .transparent, // Transparent to create the donut effect
                title: '',
              ),
            ],
            centerSpaceRadius: 50,
            sectionsSpace: 2,
            borderData: FlBorderData(
              show: true,
            ),
          ),
        ),
        Text(
          '${(widget.dataValue * 360).toInt()}',
          style: GoogleFonts.reemKufi(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class HorizontalBarChart extends StatefulWidget {
  final Map<String, double> data;
  const HorizontalBarChart({super.key, required this.data});

  @override
  State<HorizontalBarChart> createState() => _HorizontalBarChartState();
}

class _HorizontalBarChartState extends State<HorizontalBarChart> {
  @override
  Widget build(BuildContext context) {
    return BarChart(BarChartData(
        alignment: BarChartAlignment.spaceBetween,
        maxY: widget.data.values
            .reduce((max, value) => value > max ? value : max),
        barGroups: widget.data.entries
            .map((entry) => BarChartGroupData(
                x: widget.data.keys.toList().indexOf(entry.key) + 1,
                barRods: [BarChartRodData(toY: entry.value, color: clr)]))
            .toList()));
  }
}

final clr = const Color(0xff0B1F5B);

class VideoContainer extends StatefulWidget {
  final String videoUrl;

  VideoContainer({required this.videoUrl});

  @override
  _VideoContainerState createState() => _VideoContainerState();
}

class _VideoContainerState extends State<VideoContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: VideoPlayerWidget(videoUrl: widget.videoUrl),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({required this.videoUrl});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  late IconData _playbackIcon;
  bool _isFullScreen = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl);
    _playbackIcon = Icons.play_arrow;
    _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    await _controller.initialize();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _playPause() {
    if (_controller.value.isPlaying) {
      _controller.pause();
      _playbackIcon = Icons.play_arrow;
    } else {
      _controller.play();
      _playbackIcon = Icons.pause;
    }
    setState(() {});
  }

  void _toggleFullScreen() {
    if (_isFullScreen) {
      setState(() {
        _isFullScreen = false;
      });
      _controller.play(); // Resume video playback
    } else {
      setState(() {
        _isFullScreen = true;
      });
      _controller.pause(); // Pause video playback before opening the dialog
      showDialog(
        context: context,
        builder: (context) {
          return VideoOptionsDialog(controller: _controller);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _playPause,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(35),
        ),
        width: 200,
        height: 300,
        child: _controller.value.isInitialized
            ? Stack(
                alignment: Alignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: 14 / 9,
                    child: VideoPlayer(_controller),
                  ),
                  IconButton(
                    icon: Icon(
                      _playbackIcon,
                      color: Colors.white,
                    ),
                    iconSize: 32,
                    onPressed: _playPause,
                  ),
                  Positioned(
                    right: 0,
                    child: IconButton(
                      icon: Icon(
                          _isFullScreen
                              ? Icons.fullscreen_exit
                              : Icons.fullscreen,
                          color: Colors.white),
                      iconSize: 32,
                      onPressed: _toggleFullScreen,
                    ),
                  ),
                ],
              )
            : Center(
                child: CircularProgressIndicator(
                  color: clr,
                ),
              ),
      ),
    );
  }
}

class VideoOptionsDialog extends StatefulWidget {
  final VideoPlayerController controller;

  VideoOptionsDialog({required this.controller});

  @override
  _VideoOptionsDialogState createState() => _VideoOptionsDialogState();
}

class _VideoOptionsDialogState extends State<VideoOptionsDialog> {
  late double _sliderValue;
  IconData _playbackIcon = Icons.play_arrow;
  @override
  void initState() {
    super.initState();
    _sliderValue = 0.0;

    widget.controller.addListener(_videoPlayerListener);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_videoPlayerListener);
    super.dispose();
  }

  void _videoPlayerListener() {
    if (mounted) {
      setState(() {
        _sliderValue = widget.controller.value.position.inSeconds.toDouble();
      });
    }
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void _playPausefull() {
    if (widget.controller.value.isPlaying) {
      widget.controller.pause();
      _playbackIcon = Icons.play_arrow;
    } else {
      widget.controller.play();
      _playbackIcon = Icons.pause;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.controller.value.isInitialized)
            Container(
              width: double.infinity,
              height: 500,
              child: AspectRatio(
                aspectRatio: widget.controller.value.aspectRatio,
                child: Stack(
                  children: [
                    VideoPlayer(widget.controller),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: VideoProgressIndicator(
                        widget.controller,
                        colors: VideoProgressColors(
                            playedColor: clr, bufferedColor: Colors.black45),
                        allowScrubbing: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(_playbackIcon, color: clr),
                iconSize: 32,
                onPressed: _playPausefull,
              ),
              SizedBox(width: 16),
              IconButton(
                icon: Icon(Icons.fullscreen_exit, color: clr),
                iconSize: 32,
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) =>
                          MainHome(username: '142536', password: '142536')));
                },
              ),
            ],
          ),
          Slider(
            autofocus: true,
            activeColor: clr,
            inactiveColor: Colors.black45,
            value: _sliderValue,
            min: 0.0,
            max: widget.controller.value.duration.inSeconds.toDouble(),
            onChanged: (value) {
              setState(() {
                _sliderValue = value;
              });
              widget.controller.seekTo(Duration(seconds: value.toInt()));
            },
          ),
          Text(
            "${_formatDuration(widget.controller.value.position)} / ${_formatDuration(widget.controller.value.duration)}",
          ),
        ],
      ),
      contentPadding: EdgeInsets.all(16),
    );
  }
}

class FullScreenVideoWidget extends StatefulWidget {
  final VideoPlayerController controller;

  const FullScreenVideoWidget({required this.controller});

  @override
  _FullScreenVideoWidgetState createState() => _FullScreenVideoWidgetState();
}

class _FullScreenVideoWidgetState extends State<FullScreenVideoWidget> {
  late VideoPlayerController _controller;
  late double _sliderValue;
  String _currentPosition = '0:00';
  String _duration = '0:00';

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    _sliderValue = 0.0;

    _controller.addListener(() {
      setState(() {
        final position = _controller.value.position;
        final duration = _controller.value.duration;
        // ignore: unnecessary_null_comparison
        if (position != null && duration != null) {
          _sliderValue = position.inMilliseconds.toDouble();
          _currentPosition = _formatDuration(position);
          _duration = _formatDuration(duration);
        }
      });
    });
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void _onSliderChange(double value) {
    final newPosition = Duration(milliseconds: value.toInt());
    _controller.seekTo(newPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 800,
      height: 500,
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: VideoPlayer(_controller),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: clr,
                ),
                onPressed: () {
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                  } else {
                    _controller.play();
                  }
                },
              ),
              Slider(
                autofocus: true,
                activeColor: clr,
                inactiveColor: Colors.black45,
                value: _sliderValue,
                onChanged: _onSliderChange,
                min: 0.0,
                max: _controller.value.duration.inMilliseconds.toDouble(),
              ),
              Text(
                '$_currentPosition / $_duration',
                style: TextStyle(color: clr),
              ),
              IconButton(
                icon: Icon(
                  Icons.fullscreen_exit,
                  color: clr,
                  size: 25,
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MainHome(
                              username: '142536',
                              password:
                                  '142536'))); // Close the full-screen dialog
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
