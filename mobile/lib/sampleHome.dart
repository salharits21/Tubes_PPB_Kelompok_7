import 'package:flutter/material.dart';
import 'login.dart'; // Import halaman login

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout), // Ikon logout
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'Halaman ini nantinya berisi halaman teman saya',
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }
}
