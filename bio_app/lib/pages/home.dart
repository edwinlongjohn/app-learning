// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.indigo[800],
          body: Column(
            //change the alignment of the objects in the column the last should come first and the first should come last
            //verticalDirection: VerticalDirection.up, or to do the reverse u use: verticalDirection: VerticalDirection.down,

            //by default the column takes up all the vertical spaces but for to avoid that you use;
            //mainAxisSize: MainAxisSize.min,

            //for crossAxisAliginment to make the items stretch to the left side of the screen you can use the .stretch property
            //crossAxisAlignment: CrossAxisAlignment.stretch,

            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 15.0,
              ),
              CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage('images/passport.png'),
              ),
              SizedBox(
                height: 15.0,
              ),
              // PageView(
              //   controller: _controller,
              //   children: [
              //     Text(
              //       'Flutter Developer',
              //       style: GoogleFonts.greatVibes(
              //         textStyle: TextStyle(
              //           color: Color.fromARGB(255, 224, 241, 238),
              //           letterSpacing: 2.5,
              //           fontSize: 25,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     ),
              //     Text(
              //       'Flutter Developer',
              //       style: GoogleFonts.greatVibes(
              //         textStyle: TextStyle(
              //           color: Color.fromARGB(255, 224, 241, 238),
              //           letterSpacing: 2.5,
              //           fontSize: 25,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     ),
              //     Text(
              //       'Flutter Developer',
              //       style: GoogleFonts.greatVibes(
              //         textStyle: TextStyle(
              //           color: Color.fromARGB(255, 224, 241, 238),
              //           letterSpacing: 2.5,
              //           fontSize: 25,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              SmoothPageIndicator(
                controller: _controller,
                count: 3,
                effect: const WormEffect(
                  dotHeight: 16,
                  dotWidth: 16,
                  type: WormType.thinUnderground,
                ),
              ),
              SizedBox(
                height: 2.0,
                width: 150,
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              Card(
                margin: EdgeInsets.symmetric(
                  horizontal: 25.0,
                  vertical: 10.0,
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.phone_android,
                    color: Colors.cyan[600],
                  ),
                  title: Text(
                    '+234-90-180-960-86',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(
                  horizontal: 25.0,
                  vertical: 5.0,
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.email_outlined,
                    color: Colors.cyan[600],
                  ),
                  title: Text(
                    'edwinlongjohn@gmail.com',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
