import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:seatsnap/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainHome(username: '123456', password: '123456'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late GlobalKey<ScaffoldState> _scaffoldKey;
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final clr = Color(0xff0B1F5B);
  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final username = _usernameController.text;
      final password = _passwordController.text;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Username: $username\nPassword: $password'),
        ),
      );
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => MainHome(
                    username: username,
                    password: password,
                  )),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            _scaffoldKey.currentState?.openDrawer(); // Open the drawer
          },
          child: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xff0B1F5B),
        title: Text(
          widget.title,
          style: GoogleFonts.reemKufi(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double screenWidth = constraints.maxWidth;
          final bool isDesktop = screenWidth >= 900;

          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 35, vertical: 75),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'MyNest \nSeat Booking System',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.reemKufi(
                                fontSize: isDesktop ? 45 : 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Reserve, Sit, Succeed !',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.reemKufi(
                                fontSize: isDesktop ? 28 : 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isDesktop) const Spacer(),
                      if (isDesktop)
                        Container(
                          height: 400,
                          width: 500,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xff0B1F5B),
                              width: 5,
                            ),
                            borderRadius: BorderRadius.circular(45),
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Login',
                                  style: GoogleFonts.reemKufi(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: TextFormField(
                                    controller: _usernameController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter a username';
                                      }
                                      return null;
                                    },
                                    autocorrect: true,
                                    decoration: const InputDecoration(
                                      labelText: 'Username',
                                      labelStyle: TextStyle(),
                                      alignLabelWithHint: true,
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 15,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter a password+';
                                      }
                                      return null;
                                    },
                                    autocorrect: true,
                                    obscureText: true,
                                    controller: _passwordController,
                                    decoration: const InputDecoration(
                                      labelText: 'Password',
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 15,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: ElevatedButton(
                                      onPressed: _submitForm,
                                      style: ElevatedButton.styleFrom(
                                          fixedSize: Size(150, 75),
                                          backgroundColor: clr,
                                          side: BorderSide.none,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15))),
                                      child: Text(
                                        'Submit',
                                        style: GoogleFonts.reemKufi(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
