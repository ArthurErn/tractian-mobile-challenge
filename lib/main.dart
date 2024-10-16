import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import './providers/data_provider.dart';
import './screens/home_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DataProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asset Tree App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.robotoTextTheme(), // Usando a fonte Roboto
        appBarTheme: AppBarTheme(
          color: Colors.blueAccent,
          elevation: 2,
          centerTitle: true,
          titleTextStyle: GoogleFonts.roboto(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}
