import 'package:flutter/material.dart';
import 'splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clean Quest', // Menambahkan title aplikasi
      theme: ThemeData(
        primarySwatch: Colors.blue, // Warna utama untuk aplikasi
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), // Panggil halaman login
    );
  }
}
