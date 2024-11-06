import 'package:flutter/material.dart';
import 'database.dart';
import 'register.dart';
import 'sampleHome.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    // Pastikan untuk membuang controller saat halaman dihapus
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Variabel untuk mengontrol skala tombol
  double scale = 1.0;
  double opact = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('asset/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Judul
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
              const SizedBox(height: 80), // Jarak setelah judul

              // Nama Field
              textField(label: "Nama", controller: nameController),

              const SizedBox(height: 10),

              // Password Field
              textField(
                  label: "Password",
                  isPassword: true,
                  controller: passwordController),

              const SizedBox(height: 30),

              // Tombol Login
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ),
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

  // Method untuk membangun TextField
  Widget textField(
      {required String label,
      bool isPassword = false,
      required TextEditingController controller}) {
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
            controller: controller, // Controller untuk TextField
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

  // Method untuk membangun tombol dengan gambar
  Widget button() {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          scale = 0.9;
          opact = 0.7;
        });
      },
      onTapUp: (_) {
        setState(() {
          scale = 1.0;
          opact = 1.0;
        });
        login(); // Panggil fungsi login ketika tombol ditekan
      },
      child: AnimatedOpacity(
        opacity: opact,
        duration: const Duration(milliseconds: 100),
        child: AnimatedScale(
          scale: scale,
          duration: const Duration(milliseconds: 100),
          child: Image.asset(
            'asset/button.png', // Ganti dengan path gambar Anda
          ),
        ),
      ),
    );
  }

  void login() {
    String name = nameController.text; // Ambil nama dari TextField
    String password = passwordController.text; // Ambil password dari TextField
    int passval = 6;

    // Validasi input
    if (name.isEmpty || password.isEmpty) {
      // Tampilkan pesan kesalahan jika field kosong
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama dan password harus diisi')),
      );
      return;
    }

    if (password.length < passval) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Password harus terdiri dari minimal 6 karakter')),
      );
      return;
    }

    

    // Mencari user di database
    User? user = userDatabase.loginUser(name, password); // Panggil fungsi loginUser dengan nama dan password

    if (user != null) {
      print('Login successful for user: ${user.name}'); // Berhasil login
      // Navigasi ke halaman utama setelah login berhasil
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      print('Login failed: Invalid name or password'); // Gagal login
      // Tampilkan pesan kesalahan jika login gagal
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login failed: Invalid name or password')),
      );
    }

    nameController.clear();
    passwordController.clear();
  }
}
