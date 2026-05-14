import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      theme: ThemeData(

        useMaterial3: true,

        scaffoldBackgroundColor:
            const Color(0xffEFE8DD),

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff3C2A21),
        ),

        textTheme:
            GoogleFonts.poppinsTextTheme(),

        appBarTheme: const AppBarTheme(

          backgroundColor:
              Color(0xffEFE8DD),

          elevation: 0,

          centerTitle: false,
        ),
      ),

      home: const LoginScreen(),
    );
  }
}