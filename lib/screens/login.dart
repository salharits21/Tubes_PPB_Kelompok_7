import 'package:flutter/material.dart';
import 'package:tubes_home/screens/register.dart';
import 'home_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController emailOrUsernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailOrUsernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  double scale = 1.0;
  double opacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Title
              Container(
                padding: const EdgeInsets.only(bottom: 60, top: 100),
                child: const Text(
                  'Clean Quest',
                  style: TextStyle(
                    fontSize: 45,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 80),

              // Name Field
              textField(label: "Username", controller: emailOrUsernameController),

              const SizedBox(height: 10),

              // Password Field
              textField(
                label: "Password",
                isPassword: true,
                controller: passwordController,
              ),

              const SizedBox(height: 30),

              // Login Button
              button(),

              const SizedBox(height: 250),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Belum memiliki akun? ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterPage()),
                      );
                    },
                    child: const Text(
                      "Daftar",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method for TextField
  Widget textField({
    required String label,
    bool isPassword = false,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 15, bottom: 5),
          child: Text(
            label,
            style: const TextStyle(color: Colors.white, fontFamily: 'Poppins'),
          ),
        ),
        Container(
          height: 42,
          width: 350,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            controller: controller,
            obscureText: isPassword,
            style: const TextStyle(
              fontSize: 13,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
            ),
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
            ),
          ),
        ),
      ],
    );
  }

  // Login button with animation
  Widget button() {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          scale = 0.9;
          opacity = 0.7;
        });
      },
      onTapUp: (_) {
        setState(() {
          scale = 1.0;
          opacity = 1.0;
        });
        FocusScope.of(context).unfocus();
        login(); // Call login function when button is tapped
      },
      child: AnimatedOpacity(
        opacity: opacity,
        duration: const Duration(milliseconds: 100),
        child: AnimatedScale(
          scale: scale,
          duration: const Duration(milliseconds: 100),
          child: Image.asset(
            'assets/images/button.png', // Path to your button image
          ),
        ),
      ),
    );
  }

  // Login function to connect to Laravel API
  void login() async {
    String emailOrUsername = emailOrUsernameController.text; // Ambil nama dari text field
    String password = passwordController.text; // Ambil password dari text field

    // Validasi input
    if (emailOrUsername.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama dan password harus diisi')),
      );
      return;
    }

    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Password harus terdiri dari minimal 6 karakter')),
      );
      return;
    }

    try {
      // Kirim data login langsung tanpa CSRF token
      var response = await http.post(
        Uri.parse(
            'http://10.0.2.2:8000/api/api/login'), // Ganti dengan URL API login Laravel Anda
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'username_or_email': emailOrUsername,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print('Login berhasil: ${responseData['message']}');

        int userId = responseData['user']['id']; // Ambil userId dari respons API

        // Navigasi ke halaman home setelah login berhasil
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen(userId: userId)), // Kirim userId ke HomeScreen
        );
      } else {
        print('Login gagal: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login gagal. Username atau password salah!')),
        );
      }
    } catch (e) {
      print('Error selama login: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Terjadi kesalahan. Coba lagi nanti')),
      );
    }
  }
}
